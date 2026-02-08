WITH m AS (
  WITH base AS (
    SELECT
      DATE_TRUNC('month', dd.date)::date AS month,
      s.customer_segment,
      fs.customer_id,
      fs.invoice_no,
      fs.revenue
    FROM dw.fact_sales fs
    JOIN dw.dim_date dd ON dd.date_key = fs.date_key
    JOIN marts.customer_segments s ON s.customer_id = fs.customer_id
    WHERE fs.is_return = FALSE
  )
  SELECT
    month,
    customer_segment,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT invoice_no)  AS orders,
    SUM(revenue)                AS revenue
  FROM base
  GROUP BY month, customer_segment
),
k AS (
  SELECT
    month,
    customer_segment,
    customers,
    orders,
    revenue,
    (orders::numeric / NULLIF(customers, 0)) AS orders_per_customer,
    (revenue::numeric / NULLIF(orders, 0))   AS aov
  FROM m
),
w AS (
  SELECT
    *,
    LAG(customers) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_customers,
    LAG(orders_per_customer) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_opc,
    LAG(aov) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_aov,
    LAG(revenue) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_revenue
  FROM k
),
decomp AS (
  SELECT
    month,
    customer_segment,
    prev_revenue,
    revenue,
    (revenue - prev_revenue) AS delta_revenue,

    -- Stepwise decomposition (order matters; consistent and explainable)
    (customers - prev_customers) * prev_opc * prev_aov                         AS driver_customers,
    customers * (orders_per_customer - prev_opc) * prev_aov                    AS driver_frequency,
    customers * orders_per_customer * (aov - prev_aov)                         AS driver_aov
  FROM w
  WHERE prev_revenue IS NOT NULL
)
SELECT
  month,
  customer_segment,
  ROUND(prev_revenue, 2) AS prev_revenue,
  ROUND(revenue, 2)      AS revenue,
  ROUND(delta_revenue, 2) AS delta_revenue,
  ROUND(driver_customers, 2) AS driver_customers,
  ROUND(driver_frequency, 2) AS driver_frequency,
  ROUND(driver_aov, 2)       AS driver_aov,
  ROUND((driver_customers + driver_frequency + driver_aov), 2) AS explained_delta
FROM decomp
ORDER BY month, customer_segment;
