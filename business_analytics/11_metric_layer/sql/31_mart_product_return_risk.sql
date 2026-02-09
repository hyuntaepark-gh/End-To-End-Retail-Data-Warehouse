CREATE OR REPLACE VIEW dw.mart_product_return_risk AS
SELECT
  stock_code,
  SUM(CASE WHEN is_return = true THEN revenue ELSE 0 END) AS return_revenue,
  SUM(CASE WHEN is_return = false THEN revenue ELSE 0 END) AS net_revenue,
  COUNT(DISTINCT CASE WHEN is_return = true THEN invoice_no END) AS return_orders,
  COUNT(DISTINCT CASE WHEN is_return = false THEN invoice_no END) AS net_orders,
  COUNT(DISTINCT CASE WHEN is_return = true THEN invoice_no END)::numeric
    / NULLIF(COUNT(DISTINCT invoice_no), 0) AS return_rate
FROM dw.v_sales_enriched
GROUP BY 1
ORDER BY return_revenue DESC;
