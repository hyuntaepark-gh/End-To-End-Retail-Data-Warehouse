SELECT
  customer_id,
  COUNT(DISTINCT invoice_no) AS orders,
  SUM(revenue)               AS revenue,
  AVG(revenue)               AS avg_order_value
FROM dw.v_sales_enriched
WHERE invoice_no NOT LIKE 'C%'
GROUP BY 1;
