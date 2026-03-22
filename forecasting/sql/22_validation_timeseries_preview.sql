SELECT
    stock_code,
    year,
    month,
    revenue,
    revenue_lag1,
    revenue_lag2,
    revenue_lag3,
    rolling_3m_avg,
    rolling_6m_avg
FROM ml.feature_monthly_sales
ORDER BY stock_code, year, month
LIMIT 100;