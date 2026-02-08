-- Product-level base metrics
SELECT
  fs.stock_code,
  dp.description,
  COUNT(DISTINCT fs.invoice_no) AS orders,
  SUM(fs.quantity) AS units_sold,
  SUM(fs.revenue) AS revenue,
  SUM(fs.revenue) / NULLIF(SUM(fs.quantity), 0) AS avg_price_per_unit
FROM dw.fact_sales fs
LEFT JOIN dw.dim_product dp
  ON dp.stock_code = fs.stock_code
WHERE fs.is_return = FALSE
GROUP BY fs.stock_code, dp.description;
