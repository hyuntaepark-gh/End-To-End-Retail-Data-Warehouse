SELECT
  date_trunc('month', to_date(date_key::text, 'YYYYMMDD'))::date AS month,
  COUNT(DISTINCT invoice_no) AS orders
FROM dw.v_sales_enriched
WHERE is_return = false
GROUP BY 1
ORDER BY 1;