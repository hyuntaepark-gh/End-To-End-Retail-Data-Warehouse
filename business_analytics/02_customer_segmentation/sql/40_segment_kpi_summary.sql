SELECT
    s.customer_segment,
    COUNT(DISTINCT fs.customer_id) AS customers,
    COUNT(DISTINCT fs.invoice_no)::numeric / COUNT(DISTINCT fs.customer_id) AS orders_per_customer,
    SUM(fs.revenue) / COUNT(DISTINCT fs.invoice_no) AS avg_order_value,
    SUM(fs.revenue) / COUNT(DISTINCT fs.customer_id) AS revenue_per_customer,
    SUM(fs.revenue) AS total_revenue
FROM dw.fact_sales fs
JOIN marts.customer_segments s
  ON s.customer_id = fs.customer_id
WHERE fs.is_return = FALSE
GROUP BY s.customer_segment
ORDER BY total_revenue DESC;
