WITH monthly_product AS (
    SELECT
        DATE_TRUNC('month', dd.date)::date AS month,
        s.customer_segment,
        fs.stock_code,
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
        s.customer_segment,
        fs.stock_code
),

changes AS (
    SELECT
        month,
        customer_segment,
        stock_code,
        avg_price,
        units,
        (avg_price - LAG(avg_price) OVER (
            PARTITION BY customer_segment, stock_code
            ORDER BY month
        )) / NULLIF(LAG(avg_price) OVER (
            PARTITION BY customer_segment, stock_code
            ORDER BY month
        ), 0) AS price_change_pct,

        (units - LAG(units) OVER (
            PARTITION BY customer_segment, stock_code
            ORDER BY month
        )) / NULLIF(LAG(units) OVER (
            PARTITION BY customer_segment, stock_code
            ORDER BY month
        ), 0) AS unit_change_pct
    FROM monthly_product
),

clean AS (
    SELECT *
    FROM changes
    WHERE price_change_pct IS NOT NULL
      AND unit_change_pct IS NOT NULL
      AND ABS(price_change_pct) > 0.0001
)

SELECT
    customer_segment,
    COUNT(*) AS observations,
    ROUND(
        regr_slope(unit_change_pct, price_change_pct)::numeric,
        4
    ) AS elasticity_same_product,
    ROUND(
        regr_r2(unit_change_pct, price_change_pct)::numeric,
        4
    ) AS r2
FROM clean
GROUP BY customer_segment
ORDER BY elasticity_same_product;
