SELECT
    stock_code,
    COUNT(*) AS month_count
FROM ml.feature_monthly_sales
GROUP BY stock_code
ORDER BY month_count DESC, stock_code;