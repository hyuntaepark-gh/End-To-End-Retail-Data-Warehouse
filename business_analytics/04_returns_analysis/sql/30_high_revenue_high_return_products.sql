SELECT
  dp.description,
  SUM(fs.revenue) AS revenue,
  ROUND(
    100.0 * COUNT(DISTINCT CASE WHEN fs.is_return THEN fs.invoice_no END)
    / NULLIF(COUNT(DISTINCT fs.invoice_no), 0),
    2
  ) AS return_rate_pct
FROM dw.fact_sales fs
LEFT JOIN dw.dim_product dp
  ON dp.stock_code = fs.stock_code
GROUP BY dp.description
HAVING SUM(fs.revenue) > 10000
ORDER BY return_rate_pct DESC;
