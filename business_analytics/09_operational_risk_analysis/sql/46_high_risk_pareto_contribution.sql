WITH sku AS (
  SELECT
    stock_code,
    SUM(CASE WHEN invoice_no LIKE 'C%' THEN ABS(revenue) ELSE 0 END) AS return_loss
  FROM dw.v_sales_enriched
  GROUP BY 1
),
ranked AS (
  SELECT
    stock_code,
    return_loss,
    SUM(return_loss) OVER () AS total_return_loss,
    SUM(return_loss) OVER (
      ORDER BY return_loss DESC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_return_loss
  FROM sku
  WHERE return_loss > 0
)
SELECT
  stock_code,
  return_loss,
  cumulative_return_loss,
  cumulative_return_loss / total_return_loss AS cumulative_share
FROM ranked
ORDER BY return_loss DESC;
