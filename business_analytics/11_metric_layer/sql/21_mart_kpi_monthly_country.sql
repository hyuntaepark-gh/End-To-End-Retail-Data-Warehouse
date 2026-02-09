CREATE OR REPLACE VIEW dw.mart_kpi_monthly_country AS
 SELECT
   v.year,
   v.month,
   c.country,
   COUNT(DISTINCT v.invoice_no) AS orders,
   COUNT(DISTINCT v.customer_id) AS customers,
   SUM(v.revenue) AS revenue,
   SUM(v.revenue) / NULLIF(COUNT(DISTINCT v.invoice_no), 0) AS aov
 FROM dw.v_sales_enriched v
 JOIN dw.dim_customer c
   ON v.customer_id = c.customer_id
WHERE v.is_return = false
GROUP BY 1,2,3;