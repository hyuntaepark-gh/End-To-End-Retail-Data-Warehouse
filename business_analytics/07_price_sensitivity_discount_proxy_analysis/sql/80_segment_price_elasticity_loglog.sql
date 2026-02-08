WITH monthly AS (
    SELECT
        DATE_TRUNC('month', dd.date)::date AS month,
        s.customer_segment,
        SUM(fs.quantity) AS units,
        SUM(fs.revenue) / NULLIF(SUM(fs.quantity), 0) AS avg_price
    FROM dw.fact_sales fs
    JOIN dw.dim_date dd
        ON dd.date_key = fs.date_key
    JOIN marts.customer_segments s
        ON s.customer_id = fs.customer_id
    WHERE fs.is_return = FALSE
    GROUP BY
        DATE_TRUNC('month', dd.date)::date,
        s.customer_segment
),

clean AS (
    SELECT
        customer_segment,
        LN(units) AS ln_units,
        LN(avg_price) AS ln_price
    FROM monthly
    WHERE units > 0
      AND avg_price > 0
)

SELECT
    customer_segment,
    COUNT(*) AS months_used,
    ROUND(
        regr_slope(ln_units, ln_price)::numeric,
        4
    ) AS log_log_elasticity,
    ROUND(
        regr_r2(ln_units, ln_price)::numeric,
        4
    ) AS r2
FROM clean
GROUP BY customer_segment
ORDER BY log_log_elasticity;
