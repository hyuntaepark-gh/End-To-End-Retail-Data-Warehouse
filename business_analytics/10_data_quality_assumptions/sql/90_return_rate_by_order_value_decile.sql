WITH deciled AS (
  SELECT
    revenue,
    NTILE(10) OVER (ORDER BY revenue) AS order_value_decile
  FROM dw.v_sales_enriched
)
SELECT
  order_value_decile,
  COUNT(*) AS orders,
  COUNT(*) FILTER (WHERE revenue < 0) AS return_orders,
  ROUND(
    100.0 * COUNT(*) FILTER (WHERE revenue < 0) / COUNT(*),
    2
  ) AS return_rate_pct
FROM deciled
GROUP BY order_value_decile
ORDER BY order_value_decile;
