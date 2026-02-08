DROP VIEW IF EXISTS marts.kpi_top_products;

CREATE VIEW marts.kpi_top_products AS
SELECT
  fs.stock_code,
  dp.description,
  SUM(CASE WHEN fs.is_return THEN 0 ELSE fs.revenue END) AS net_revenue,
  SUM(CASE WHEN fs.is_return THEN 0 ELSE fs.quantity END) AS units_sold,
  COUNT(DISTINCT fs.invoice_no) AS orders
FROM dw.fact_sales fs
LEFT JOIN dw.dim_product dp ON dp.stock_code = fs.stock_code
GROUP BY fs.stock_code, dp.description;
