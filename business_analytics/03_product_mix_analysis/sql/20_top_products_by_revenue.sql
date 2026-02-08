-- Top products by total revenue
SELECT
  dp.description,
  SUM(fs.revenue) AS revenue,
  COUNT(DISTINCT fs.invoice_no) AS orders,
  SUM(fs.quantity) AS units_sold
FROM dw.fact_sales fs
LEFT JOIN dw.dim_product dp
  ON dp.stock_code = fs.stock_code
WHERE fs.is_return = FALSE
GROUP BY dp.description
ORDER BY revenue DESC
LIMIT 20;
