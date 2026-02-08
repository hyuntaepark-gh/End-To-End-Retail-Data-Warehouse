WITH base AS (
  SELECT
    DATE_TRUNC('month', dd.date)::date AS month,
    s.customer_segment,
    fs.customer_id,
    fs.invoice_no,
    fs.quantity,
    fs.revenue
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON dd.date_key = fs.date_key
  JOIN marts.customer_segments s
    ON s.customer_id = fs.customer_id
  WHERE fs.is_return = FALSE
),
agg AS (
  SELECT
    month,
    customer_segment,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT invoice_no)  AS orders,
    SUM(quantity)               AS units,
    SUM(revenue)                AS revenue
  FROM base
  GROUP BY month, customer_segment
)
SELECT
  month,
  customer_segment,
  customers,
  orders,
  units,
  revenue,
  ROUND(revenue / NULLIF(orders, 0), 2) AS aov,              -- avg order value
  ROUND(revenue / NULLIF(units, 0), 4)  AS avg_unit_price,   -- blended price
  ROUND(units   / NULLIF(orders, 0), 2) AS units_per_order,
  ROUND(orders  / NULLIF(customers, 0), 3) AS orders_per_customer
FROM agg
ORDER BY month, customer_segment;
