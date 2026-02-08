-- Monthly base metrics: revenue, orders, customers, AOV
SELECT
  dd.year,
  dd.month,
  (dd.year * 100 + dd.month) AS year_month,
  COUNT(DISTINCT fs.invoice_no) AS orders,
  COUNT(DISTINCT fs.customer_id) AS customers,
  SUM(fs.revenue) AS revenue,
  SUM(fs.revenue) / NULLIF(COUNT(DISTINCT fs.invoice_no), 0) AS aov
FROM dw.fact_sales fs
JOIN dw.dim_date dd ON dd.date_key = fs.date_key
WHERE fs.is_return = FALSE
GROUP BY dd.year, dd.month
ORDER BY year_month;