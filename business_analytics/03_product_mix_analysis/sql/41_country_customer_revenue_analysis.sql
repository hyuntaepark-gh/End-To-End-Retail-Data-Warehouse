SELECT
  customer_country,
  COUNT(DISTINCT customer_id) AS customers,
  SUM(revenue)                AS revenue,
  AVG(revenue)                AS revenue_per_customer
FROM dw.v_sales_enriched
GROUP BY 1
ORDER BY revenue DESC;
