WITH m AS (
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
w AS (
    SELECT
        *,
        LAG(units) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_units,
        LAG(avg_price) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_price
    FROM m
)
SELECT
    month,
    customer_segment,
    (avg_price - prev_price) / NULLIF(prev_price, 0) AS price_change_pct,
    (units - prev_units) / NULLIF(prev_units, 0) AS unit_change_pct
FROM w
WHERE prev_price IS NOT NULL
ORDER BY customer_segment, month;
