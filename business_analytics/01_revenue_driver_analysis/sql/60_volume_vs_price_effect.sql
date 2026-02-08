-- Volume vs Price effect decomposition
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', dd.date)::date AS month,
        SUM(fs.quantity) AS units_sold,
        SUM(fs.revenue) AS revenue,
        SUM(fs.revenue) / NULLIF(SUM(fs.quantity), 0) AS avg_price
    FROM dw.fact_sales fs
    JOIN dw.dim_date dd ON dd.date_key = fs.date_key
    WHERE fs.is_return = FALSE
    GROUP BY 1
),
lagged AS (
    SELECT
        *,
        LAG(units_sold) OVER (ORDER BY month) AS prev_units,
        LAG(avg_price)  OVER (ORDER BY month) AS prev_price,
        LAG(revenue)    OVER (ORDER BY month) AS prev_revenue
    FROM monthly
)
SELECT
    month,
    revenue - prev_revenue AS revenue_change,
    (units_sold - prev_units) * prev_price AS volume_effect,
    (avg_price - prev_price) * prev_units  AS price_effect,
    (revenue - prev_revenue)
      - ((units_sold - prev_units) * prev_price
      +  (avg_price - prev_price) * prev_units) AS residual
FROM lagged
ORDER BY month;
