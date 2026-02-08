SELECT
  COUNT(DISTINCT CASE WHEN fs.is_return THEN fs.invoice_no END) AS return_orders,
  COUNT(DISTINCT fs.invoice_no) AS total_orders,
  ROUND(
    100.0 * COUNT(DISTINCT CASE WHEN fs.is_return THEN fs.invoice_no END)
    / NULLIF(COUNT(DISTINCT fs.invoice_no), 0),
    2
  ) AS return_rate_pct,
  SUM(CASE WHEN fs.is_return THEN fs.revenue END) AS returned_revenue,
  SUM(fs.revenue) AS total_revenue
FROM dw.fact_sales fs;
