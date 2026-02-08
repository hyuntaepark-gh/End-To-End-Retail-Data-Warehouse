SELECT
  DATE_TRUNC('month', dd.date)::date AS month,
  SUM(CASE WHEN fs.is_return THEN fs.revenue END) AS returned_revenue,
  SUM(CASE WHEN NOT fs.is_return THEN fs.revenue END) AS gross_revenue,
  ROUND(
    100.0 * ABS(SUM(CASE WHEN fs.is_return THEN fs.revenue END))
    / NULLIF(SUM(CASE WHEN NOT fs.is_return THEN fs.revenue END), 0),
    2
  ) AS return_loss_pct_of_gross
FROM dw.fact_sales fs
JOIN dw.dim_date dd
  ON dd.date_key = fs.date_key
GROUP BY DATE_TRUNC('month', dd.date)
ORDER BY month;
