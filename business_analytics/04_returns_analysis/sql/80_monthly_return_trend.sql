SELECT
  DATE_TRUNC('month', dd.date)::date AS month,
  COUNT(DISTINCT CASE WHEN fs.is_return THEN fs.invoice_no END) AS return_orders,
  COUNT(DISTINCT fs.invoice_no) AS total_orders,
  ROUND(
    100.0 * COUNT(DISTINCT CASE WHEN fs.is_return THEN fs.invoice_no END)
    / NULLIF(COUNT(DISTINCT fs.invoice_no), 0),
    2
  ) AS return_rate_pct
FROM dw.fact_sales fs
JOIN dw.dim_date dd
  ON dd.date_key = fs.date_key
GROUP BY DATE_TRUNC('month', dd.date)
ORDER BY month;
