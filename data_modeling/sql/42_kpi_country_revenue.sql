DROP VIEW IF EXISTS marts.kpi_country_revenue;

CREATE VIEW marts.kpi_country_revenue AS
SELECT
  dc.country,
  SUM(CASE WHEN fs.is_return THEN 0 ELSE fs.revenue END) AS net_revenue,
  COUNT(DISTINCT fs.invoice_no) AS orders,
  COUNT(DISTINCT fs.customer_id) AS customers
FROM dw.fact_sales fs
JOIN dw.dim_customer dc ON dc.customer_id = fs.customer_id
GROUP BY dc.country;
