-- Growth attribution: New vs Existing customers
WITH customer_month AS (
    SELECT
        DATE_TRUNC('month', dd.date)::date AS month,
        fs.customer_id,
        SUM(fs.revenue) AS revenue
    FROM dw.fact_sales fs
    JOIN dw.dim_date dd ON dd.date_key = fs.date_key
    WHERE fs.is_return = FALSE
    GROUP BY 1, fs.customer_id
),
first_purchase AS (
    SELECT
        customer_id,
        MIN(month) AS first_month
    FROM customer_month
    GROUP BY customer_id
),
tagged AS (
    SELECT
        cm.month,
        CASE
            WHEN cm.month = fp.first_month THEN 'new'
            ELSE 'existing'
        END AS customer_type,
        SUM(cm.revenue) AS revenue
    FROM customer_month cm
    JOIN first_purchase fp
      ON cm.customer_id = fp.customer_id
    GROUP BY cm.month, customer_type
)
SELECT
    month,
    SUM(revenue) FILTER (WHERE customer_type = 'new')       AS new_customer_revenue,
    SUM(revenue) FILTER (WHERE customer_type = 'existing')  AS existing_customer_revenue,
    SUM(revenue)                                            AS total_revenue
FROM tagged
GROUP BY month
ORDER BY month;
