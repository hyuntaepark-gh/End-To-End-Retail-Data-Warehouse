SELECT
  dd.year,
  dd.month,
  (dd.year * 100 + dd.month) AS year_month,
  SUM(CASE WHEN fs.is_return THEN 0 ELSE fs.revenue END) AS net_revenue,
  SUM(CASE WHEN fs.is_return THEN fs.revenue ELSE 0 END) AS returns_value,
  SUM(fs.revenue) AS gross_revenue,
  SUM(CASE WHEN fs.is_return THEN fs.revenue ELSE 0 END) / NULLIF(SUM(fs.revenue), 0) AS return_ratio
FROM dw.fact_sales fs
JOIN dw.dim_date dd ON dd.date_key = fs.date_key
GROUP BY dd.year, dd.month
ORDER BY year_month;
