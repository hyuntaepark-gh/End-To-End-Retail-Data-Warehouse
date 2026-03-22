SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN revenue_lag1 IS NULL THEN 1 ELSE 0 END) AS null_lag1_rows,
    ROUND(
        100.0 * SUM(CASE WHEN revenue_lag1 IS NULL THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS null_lag1_pct
FROM ml.feature_monthly_sales;