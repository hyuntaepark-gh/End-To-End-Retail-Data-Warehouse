SELECT
  PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY revenue) AS p50_order_revenue,
  PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY revenue) AS p95_order_revenue,
  PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY revenue) AS p99_order_revenue
FROM dw.v_sales_enriched
WHERE revenue IS NOT NULL;
