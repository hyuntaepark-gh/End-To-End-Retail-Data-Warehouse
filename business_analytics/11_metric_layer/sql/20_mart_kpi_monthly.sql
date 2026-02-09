CREATE OR REPLACE VIEW dw.mart_kpi_monthly AS
SELECT
  year,
  month,
  COUNT(DISTINCT invoice_no) AS orders,
  COUNT(DISTINCT customer_id) AS customers,
  SUM(revenue) AS revenue,
  SUM(revenue) / NULLIF(COUNT(DISTINCT invoice_no), 0) AS aov
FROM dw.v_sales_enriched
WHERE is_return = false
GROUP BY 1, 2;
