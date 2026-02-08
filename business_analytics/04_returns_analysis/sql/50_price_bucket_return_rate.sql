WITH priced AS (
  SELECT
    fs.invoice_no,
    fs.is_return,
    fs.revenue / NULLIF(fs.quantity, 0) AS unit_price
  FROM dw.fact_sales fs
)
SELECT
  WIDTH_BUCKET(unit_price, 0, 100, 5) AS price_bucket,
  COUNT(DISTINCT CASE WHEN is_return THEN invoice_no END) AS return_orders,
  COUNT(DISTINCT invoice_no) AS total_orders,
  ROUND(
    100.0 * COUNT(DISTINCT CASE WHEN is_return THEN invoice_no END)
    / NULLIF(COUNT(DISTINCT invoice_no), 0),
    2
  ) AS return_rate_pct
FROM priced
GROUP BY price_bucket
ORDER BY price_bucket;
