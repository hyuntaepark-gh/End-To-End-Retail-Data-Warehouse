WITH cust_orders AS (
  SELECT
    s.customer_segment,
    fs.customer_id,
    COUNT(DISTINCT fs.invoice_no) AS orders
  FROM dw.fact_sales fs
  JOIN marts.customer_segments s ON s.customer_id = fs.customer_id
  WHERE fs.is_return = FALSE
  GROUP BY s.customer_segment, fs.customer_id
)
SELECT
  customer_segment,
  COUNT(*) AS customers,
  COUNT(*) FILTER (WHERE orders >= 2) AS repeat_customers,
  (COUNT(*) FILTER (WHERE orders >= 2))::numeric / NULLIF(COUNT(*), 0) AS repeat_rate
FROM cust_orders
GROUP BY customer_segment
ORDER BY repeat_rate DESC;
