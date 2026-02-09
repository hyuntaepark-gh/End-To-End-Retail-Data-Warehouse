CREATE OR REPLACE VIEW dw.mart_returns_monthly AS
SELECT
  year,
  month,
  COUNT(DISTINCT CASE WHEN is_return = true THEN invoice_no END) AS return_orders,
  SUM(CASE WHEN is_return = true THEN revenue ELSE 0 END) AS return_revenue,
  COUNT(DISTINCT invoice_no) AS total_orders,
  COUNT(DISTINCT CASE WHEN is_return = true THEN invoice_no END)::numeric
    / NULLIF(COUNT(DISTINCT invoice_no), 0) AS return_rate
FROM dw.v_sales_enriched
GROUP BY 1, 2
ORDER BY 1, 2;