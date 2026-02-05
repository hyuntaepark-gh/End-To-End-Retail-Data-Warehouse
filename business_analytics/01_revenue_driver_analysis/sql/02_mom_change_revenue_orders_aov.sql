-- Month-over-month changes in revenue drivers
WITH monthly AS (
  SELECT
    date_trunc('month', date) AS month,
    COUNT(DISTINCT invoice_no) AS orders,
    SUM(revenue)               AS revenue,
    SUM(revenue) / COUNT(DISTINCT invoice_no) AS aov
  FROM dw.v_sales_enriched
  WHERE invoice_no NOT LIKE 'C%'
  GROUP BY 1
)
SELECT
  month,
  revenue,
  revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_change,
  orders,
  orders - LAG(orders) OVER (ORDER BY month) AS orders_change,
  aov,
  aov - LAG(aov) OVER (ORDER BY month) AS aov_change
FROM monthly
ORDER BY month;
