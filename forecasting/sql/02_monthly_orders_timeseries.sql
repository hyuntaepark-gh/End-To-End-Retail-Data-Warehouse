WITH bounds AS (
    SELECT
        MIN(make_date(year, month, 1)) AS min_month,
        MAX(make_date(year, month, 1)) AS max_month
    FROM dw.v_sales_enriched
    WHERE is_return = false
),
months AS (
    SELECT generate_series(min_month, max_month, interval '1 month')::date AS month
    FROM bounds
),
orders AS (
    SELECT
        make_date(year, month, 1) AS month,
        COUNT(DISTINCT invoice_no) AS orders
    FROM dw.v_sales_enriched
    WHERE is_return = false
    GROUP BY 1
)
SELECT
    m.month,
    COALESCE(o.orders, 0) AS orders
FROM months m
LEFT JOIN orders o USING (month)
ORDER BY 1;