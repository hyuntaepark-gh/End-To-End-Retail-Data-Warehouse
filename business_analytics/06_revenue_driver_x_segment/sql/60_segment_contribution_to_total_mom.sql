-- Segment contribution (%) to total MoM revenue change
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
    COUNT(DISTINCT invoice_no) AS orders,
    SUM(quantity) AS units,
    SUM(revenue) AS revenue
  FROM base
  GROUP BY month, customer_segment
),
k AS (
  SELECT
    month,
    customer_segment,
    customers,
    orders,
    units,
    revenue,
    (orders::numeric / NULLIF(customers, 0)) AS opc,
    (revenue::numeric / NULLIF(orders, 0))    AS aov
  FROM agg
),
w AS (
  SELECT
    *,
    LAG(customers) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_customers,
    LAG(opc)       OVER (PARTITION BY customer_segment ORDER BY month) AS prev_opc,
    LAG(aov)       OVER (PARTITION BY customer_segment ORDER BY month) AS prev_aov,
    LAG(revenue)   OVER (PARTITION BY customer_segment ORDER BY month) AS prev_revenue
  FROM k
),
decomp AS (
  SELECT
    month,
    customer_segment,
    prev_revenue,
    revenue,
    (revenue - prev_revenue) AS delta_revenue,

    -- Stepwise decomposition (customer → frequency → AOV)
    (customers - prev_customers) * prev_opc * prev_aov AS driver_customers,
    customers * (opc - prev_opc) * prev_aov            AS driver_frequency,
    customers * opc * (aov - prev_aov)                 AS driver_aov
  FROM w
  WHERE prev_revenue IS NOT NULL
),
total_delta AS (
  SELECT
    month,
    SUM(delta_revenue) AS total_delta_revenue
  FROM decomp
  GROUP BY month
)
SELECT
  d.month,
  d.customer_segment,
  ROUND(d.delta_revenue, 2) AS delta_revenue,
  ROUND(t.total_delta_revenue, 2) AS total_delta_revenue,
  ROUND(
    100.0 * d.delta_revenue / NULLIF(t.total_delta_revenue, 0),
    2
  ) AS contribution_pct,
  ROUND(d.driver_customers, 2) AS driver_customers,
  ROUND(d.driver_frequency, 2) AS driver_frequency,
  ROUND(d.driver_aov, 2) AS driver_aov
FROM decomp d
JOIN total_delta t
  ON t.month = d.month
ORDER BY d.month, d.customer_segment;