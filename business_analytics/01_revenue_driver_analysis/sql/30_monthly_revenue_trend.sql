SELECT
  DATE_TRUNC('month', date)::date AS month,
  COUNT(DISTINCT invoice_no)      AS orders,
  COUNT(DISTINCT customer_id)     AS customers,
  SUM(revenue)                    AS revenue
FROM dw.v_sales_enriched
GROUP BY 1
ORDER BY 1;
