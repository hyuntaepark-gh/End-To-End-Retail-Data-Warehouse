SELECT
  fs.customer_id,
  COUNT(DISTINCT fs.invoice_no) FILTER (WHERE fs.is_return) AS return_orders
FROM dw.fact_sales fs
GROUP BY fs.customer_id
HAVING COUNT(DISTINCT fs.invoice_no) FILTER (WHERE fs.is_return) >= 3
ORDER BY return_orders DESC;
