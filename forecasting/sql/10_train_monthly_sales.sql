CREATE OR REPLACE VIEW ml.train_feature_monthly_sales AS
WITH base AS (
    SELECT
        stock_code,
        year,
        month,
        orders,
        revenue,
        aov,
        customers,
        revenue_lag1,
        revenue_lag2,
        revenue_lag3,
        rolling_3m_avg,
        rolling_6m_avg,
        COUNT(*) OVER (PARTITION BY stock_code) AS month_count
    FROM ml.feature_monthly_sales
)
SELECT
    stock_code,
    year,
    month,
    orders,
    revenue,
    aov,
    customers,
    revenue_lag1,
    revenue_lag2,
    revenue_lag3,
    rolling_3m_avg,
    rolling_6m_avg,
    month_count
FROM base
WHERE month_count >= 6
  AND revenue_lag1 IS NOT NULL;
  SELECT *
FROM ml.train_feature_monthly_sales
ORDER BY stock_code, year, month
LIMIT 50;