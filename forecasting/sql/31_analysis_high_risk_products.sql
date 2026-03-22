SELECT
    stock_code,
    MAX(historical_return_rate) AS historical_return_rate,
    COUNT(*) AS row_count
FROM ml.feature_return_risk
GROUP BY stock_code
ORDER BY historical_return_rate DESC, row_count DESC
LIMIT 20;