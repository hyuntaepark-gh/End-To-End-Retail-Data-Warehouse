SELECT
  COALESCE(customer_country, '(unknown)') AS country,
  COUNT(DISTINCT customer_id)             AS customers,
  COUNT(DISTINCT invoice_no)              AS orders,
  SUM(revenue)                            AS revenue
FROM dw.v_sales_enriched
GROUP BY 1
ORDER BY revenue DESC
LIMIT 20;
