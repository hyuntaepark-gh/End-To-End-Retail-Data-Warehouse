-- Top 3 MoM revenue change months per segment + main driver
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
    (revenue - prev_revenue) AS delta_revenue,

    (customers - prev_customers) * prev_opc * prev_aov AS driver_customers,
    customers * (opc - prev_opc) * prev_aov            AS driver_frequency,
    customers * opc * (aov - prev_aov)                 AS driver_aov
  FROM w
  WHERE prev_revenue IS NOT NULL
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY customer_segment
      ORDER BY ABS(delta_revenue) DESC
    ) AS rn
  FROM decomp
),
final AS (
  SELECT
    month,
    customer_segment,
    ROUND(delta_revenue, 2) AS delta_revenue,
    ROUND(driver_customers, 2) AS driver_customers,
    ROUND(driver_frequency, 2) AS driver_frequency,
    ROUND(driver_aov, 2) AS driver_aov,
    CASE
      WHEN ABS(driver_customers) >= ABS(driver_frequency)
       AND ABS(driver_customers) >= ABS(driver_aov)
        THEN 'customers'
      WHEN ABS(driver_frequency) >= ABS(driver_customers)
       AND ABS(driver_frequency) >= ABS(driver_aov)
        THEN 'frequency'
      ELSE 'aov'
    END AS main_driver
  FROM ranked
  WHERE rn <= 3
)
SELECT *
FROM final
ORDER BY customer_segment, ABS(delta_revenue) DESC;
