WITH base AS (
  SELECT
    fs.customer_id,
    COUNT(DISTINCT fs.invoice_no) FILTER (WHERE fs.is_return = FALSE) AS orders_non_return,
    SUM(fs.revenue) FILTER (WHERE fs.is_return = FALSE) AS revenue_non_return,
    COUNT(DISTINCT fs.invoice_no) FILTER (WHERE fs.is_return = TRUE) AS return_orders,
    COUNT(DISTINCT fs.invoice_no) AS total_orders
  FROM dw.fact_sales fs
  GROUP BY fs.customer_id
)
SELECT
  s.customer_segment,
  COUNT(*) AS customers,
  ROUND(AVG(b.revenue_non_return), 2) AS avg_ltv_per_customer,
  ROUND(AVG(b.orders_non_return::numeric), 2) AS avg_orders_per_customer,
  ROUND(100.0 * SUM(b.return_orders)::numeric / NULLIF(SUM(b.total_orders), 0), 2) AS return_rate_pct
FROM base b
JOIN marts.customer_segments s
  ON s.customer_id = b.customer_id
GROUP BY s.customer_segment
ORDER BY avg_ltv_per_customer DESC;
