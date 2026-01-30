SELECT
  customer_id,
  MIN(date) AS first_purchase,
  MAX(date) AS last_purchase,
  COUNT(DISTINCT invoice_no) AS orders,
  SUM(revenue) AS lifetime_revenue
FROM dw.v_sales_enriched
WHERE invoice_no NOT LIKE 'C%'
GROUP BY 1;
