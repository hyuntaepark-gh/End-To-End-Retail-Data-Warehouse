WITH deciled AS (
  SELECT
    revenue,
    NTILE(10) OVER (ORDER BY revenue) AS order_value_decile
  FROM dw.v_sales_enriched
)
SELECT
  order_value_decile,
  SUM(revenue) AS total_revenue,
  ABS(SUM(revenue) FILTER (WHERE revenue < 0)) AS return_revenue,
  ROUND(
    100.0 * ABS(SUM(revenue) FILTER (WHERE revenue < 0))
    / NULLIF(SUM(ABS(revenue)), 0),
    2
  ) AS return_revenue_share_pct
FROM deciled
GROUP BY order_value_decile
ORDER BY order_value_decile;
