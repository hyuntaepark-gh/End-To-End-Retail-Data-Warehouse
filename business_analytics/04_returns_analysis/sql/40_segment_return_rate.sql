SELECT
  s.customer_segment,
  COUNT(DISTINCT CASE WHEN fs.is_return THEN fs.invoice_no END) AS return_orders,
  COUNT(DISTINCT fs.invoice_no) AS total_orders,
  ROUND(
    100.0 * COUNT(DISTINCT CASE WHEN fs.is_return THEN fs.invoice_no END)
    / NULLIF(COUNT(DISTINCT fs.invoice_no), 0),
    2
  ) AS return_rate_pct
FROM dw.fact_sales fs
JOIN marts.customer_segments s
  ON s.customer_id = fs.customer_id
GROUP BY s.customer_segment
ORDER BY return_rate_pct DESC;
