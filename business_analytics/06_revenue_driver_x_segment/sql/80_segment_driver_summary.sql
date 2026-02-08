WITH base AS (
    SELECT
        DATE_TRUNC('month', dd.date)::date AS month,
        s.customer_segment,
        fs.customer_id,
        fs.invoice_no,
        fs.revenue
    FROM dw.fact_sales fs
    JOIN dw.dim_date dd
      ON dd.date_key = fs.date_key
    JOIN marts.customer_segments s
      ON s.customer_id = fs.customer_id
    WHERE fs.is_return = FALSE
),
m AS (
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
        orders::numeric / NULLIF(customers, 0) AS orders_per_customer,
        revenue::numeric / NULLIF(orders, 0)   AS aov
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
        (revenue - prev_revenue) AS delta_revenue,

        -- Revenue driver decomposition
        (customers - prev_customers) * prev_opc * prev_aov                AS driver_customers,
        customers * (orders_per_customer - prev_opc) * prev_aov           AS driver_frequency,
        customers * orders_per_customer * (aov - prev_aov)                AS driver_aov
    FROM w
    WHERE prev_revenue IS NOT NULL
)

SELECT
    customer_segment,
    COUNT(*)                             AS months_analyzed,
    ROUND(AVG(driver_customers), 2)      AS avg_driver_customers,
    ROUND(AVG(driver_frequency), 2)      AS avg_driver_frequency,
    ROUND(AVG(driver_aov), 2)            AS avg_driver_aov
FROM decomp
GROUP BY customer_segment
ORDER BY customer_segment;
