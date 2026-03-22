CREATE SCHEMA IF NOT EXISTS ml;

CREATE OR REPLACE VIEW ml.feature_monthly_sales AS
WITH monthly AS (
    SELECT
        stock_code,
        year,
        month,
        COUNT(DISTINCT invoice_no) AS orders,
        SUM(revenue) AS revenue,
        SUM(revenue) / NULLIF(COUNT(DISTINCT invoice_no), 0) AS aov,
        COUNT(DISTINCT customer_id) AS customers
    FROM dw.v_sales_enriched
    WHERE is_return = false
    GROUP BY stock_code, year, month
)
SELECT
    stock_code,
    year,
    month,
    orders,
    revenue,
    aov,
    customers,
    LAG(revenue, 1) OVER (PARTITION BY stock_code ORDER BY year, month) AS revenue_lag1,
    LAG(revenue, 2) OVER (PARTITION BY stock_code ORDER BY year, month) AS revenue_lag2,
    LAG(revenue, 3) OVER (PARTITION BY stock_code ORDER BY year, month) AS revenue_lag3,
    AVG(revenue) OVER (
        PARTITION BY stock_code
        ORDER BY year, month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3m_avg,
    AVG(revenue) OVER (
        PARTITION BY stock_code
        ORDER BY year, month
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ) AS rolling_6m_avg
FROM monthly;
SELECT *
FROM ml.feature_monthly_sales
ORDER BY stock_code, year, month
LIMIT 50;