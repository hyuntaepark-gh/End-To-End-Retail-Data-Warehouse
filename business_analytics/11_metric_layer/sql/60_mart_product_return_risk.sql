DROP VIEW IF EXISTS dw.mart_product_return_risk;

CREATE VIEW dw.mart_product_return_risk AS
SELECT
  stock_code,

  -- Order metrics
  COUNT(DISTINCT CASE WHEN is_return = false THEN invoice_no END) AS net_orders,
  COUNT(DISTINCT CASE WHEN is_return = true THEN invoice_no END)  AS return_orders,
  COUNT(DISTINCT invoice_no) AS total_orders,

  -- Revenue metrics
  SUM(CASE WHEN is_return = false THEN revenue ELSE 0 END) AS net_revenue,
  SUM(CASE WHEN is_return = true THEN revenue ELSE 0 END)  AS return_revenue,

  -- Risk indicator
  COUNT(DISTINCT CASE WHEN is_return = true THEN invoice_no END)::numeric
    / NULLIF(COUNT(DISTINCT invoice_no), 0) AS return_rate

FROM dw.v_sales_enriched
GROUP BY stock_code
ORDER BY return_revenue DESC;
