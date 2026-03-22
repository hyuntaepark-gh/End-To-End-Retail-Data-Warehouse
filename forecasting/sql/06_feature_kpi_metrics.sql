SELECT
  date_trunc('month', to_date(date_key::text, 'YYYYMMDD'))::date AS month,
  SUM(revenue) AS revenue,
  COUNT(DISTINCT invoice_no) AS orders,
  SUM(revenue) / COUNT(DISTINCT invoice_no) AS aov
FROM dw.v_sales_enriched
WHERE is_return = false
GROUP BY 1
ORDER BY 1;
