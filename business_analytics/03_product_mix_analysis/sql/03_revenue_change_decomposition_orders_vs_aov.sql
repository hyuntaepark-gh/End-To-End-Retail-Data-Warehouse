-- Revenue change decomposition: Orders vs AOV effect
WITH monthly AS (
  SELECT
    date_trunc('month', date) AS month,
    COUNT(DISTINCT invoice_no) AS orders,
    SUM(revenue)               AS revenue,
    SUM(revenue) / COUNT(DISTINCT invoice_no) AS aov
  FROM dw.v_sales_enriched
  WHERE invoice_no NOT LIKE 'C%'
  GROUP BY 1
),
lagged AS (
  SELECT
    month,
    orders,
    aov,
    revenue,
    LAG(orders)  OVER (ORDER BY month) AS prev_orders,
    LAG(aov)     OVER (ORDER BY month) AS prev_aov,
    LAG(revenue) OVER (ORDER BY month) AS prev_revenue
  FROM monthly
)
SELECT
  month,
  revenue - prev_revenue AS revenue_change,

  -- Orders effect: change in orders * previous AOV
  (orders - prev_orders) * prev_aov AS orders_effect,

  -- AOV effect: change in AOV * previous orders
  (aov - prev_aov) * prev_orders AS aov_effect

FROM lagged
WHERE prev_revenue IS NOT NULL
ORDER BY month;
