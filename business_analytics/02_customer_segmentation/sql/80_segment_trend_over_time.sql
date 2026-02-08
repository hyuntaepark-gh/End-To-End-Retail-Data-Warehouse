SELECT
  dd.year,
  dd.month,
  (dd.year*100 + dd.month) AS year_month,
  s.customer_segment,
  SUM(fs.revenue) AS revenue,
  COUNT(DISTINCT fs.invoice_no) AS orders,
  COUNT(DISTINCT fs.customer_id) AS customers
FROM dw.fact_sales fs
JOIN dw.dim_date dd ON dd.date_key = fs.date_key
JOIN marts.customer_segments s ON s.customer_id = fs.customer_id
WHERE fs.is_return = FALSE
GROUP BY dd.year, dd.month, year_month, s.customer_segment
ORDER BY year_month, s.customer_segment;
