WITH monthly AS (
  SELECT
    dd.year,
    dd.month,
    (dd.year*100 + dd.month) AS year_month,
    COUNT(DISTINCT fs.customer_id) AS customers,
    COUNT(DISTINCT fs.invoice_no) AS orders,
    SUM(fs.revenue) AS revenue
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd ON dd.date_key = fs.date_key
  WHERE fs.is_return = FALSE
  GROUP BY dd.year, dd.month
),
lagged AS (
  SELECT
    *,
    LAG(customers) OVER (ORDER BY year_month) AS prev_customers,
    LAG(orders) OVER (ORDER BY year_month) AS prev_orders,
    LAG(revenue) OVER (ORDER BY year_month) AS prev_revenue
  FROM monthly
)
SELECT
  year_month,
  revenue - prev_revenue AS revenue_delta,
  (customers - prev_customers) * (prev_orders::numeric / prev_customers) AS delta_from_customers,
  (orders - prev_orders) * (prev_revenue::numeric / prev_orders) AS delta_from_orders
FROM lagged;
