WITH m AS (
  SELECT
    year,
    month,
    SUM(CASE WHEN is_return THEN ABS(revenue) ELSE 0 END) AS total_return_loss
  FROM dw.v_sales_enriched
  GROUP BY 1, 2
),
sku_month AS (
  SELECT
    year,
    month,
    stock_code,
    SUM(CASE WHEN is_return THEN ABS(revenue) ELSE 0 END) AS sku_return_loss
  FROM dw.v_sales_enriched
  GROUP BY 1, 2, 3
),
ranked AS (
  SELECT
    year,
    month,
    stock_code,
    sku_return_loss,
    SUM(sku_return_loss) OVER (PARTITION BY year, month) AS month_return_loss_total,
    SUM(sku_return_loss) OVER (
      PARTITION BY year, month
      ORDER BY sku_return_loss DESC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_loss
  FROM sku_month
  WHERE sku_return_loss > 0
),
top10_share AS (
  SELECT
    year,
    month,
    MAX(cumulative_loss / NULLIF(month_return_loss_total, 0)) FILTER (WHERE rn = 10) AS top10_return_loss_share
  FROM (
    SELECT
      *,
      ROW_NUMBER() OVER (PARTITION BY year, month ORDER BY sku_return_loss DESC) AS rn
    FROM ranked
  ) t
  GROUP BY 1, 2
)
SELECT
  m.year,
  m.month,
  m.total_return_loss,
  t.top10_return_loss_share
FROM m
LEFT JOIN top10_share t
  ON m.year = t.year AND m.month = t.month
ORDER BY m.year, m.month;
