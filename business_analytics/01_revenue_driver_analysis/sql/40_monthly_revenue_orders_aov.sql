-- Monthly revenue drivers overview
SELECT
  date_trunc('month', date) AS month,
  COUNT(DISTINCT invoice_no) AS orders,
  SUM(revenue)               AS revenue,
  SUM(revenue) / COUNT(DISTINCT invoice_no) AS aov
FROM dw.v_sales_enriched
WHERE invoice_no NOT LIKE 'C%'  -- exclude returns
GROUP BY 1
ORDER BY 1;
