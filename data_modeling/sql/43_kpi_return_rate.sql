DROP VIEW IF EXISTS marts.kpi_return_rate;

CREATE VIEW marts.kpi_return_rate AS
SELECT
  dd.year,
  dd.month,
  (dd.year * 100 + dd.month) AS year_month,
  COUNT(*) FILTER (WHERE fs.is_return) AS return_lines,
  COUNT(*) FILTER (WHERE NOT fs.is_return) AS sales_lines,
  (COUNT(*) FILTER (WHERE fs.is_return))::numeric / NULLIF(COUNT(*), 0) AS return_rate_lines
FROM dw.fact_sales fs
JOIN dw.dim_date dd ON dd.date_key = fs.date_key
GROUP BY dd.year, dd.month;
