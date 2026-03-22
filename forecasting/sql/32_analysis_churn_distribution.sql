SELECT
    churn_label,
    COUNT(*) AS customer_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
FROM ml.feature_customer_churn
GROUP BY churn_label
ORDER BY churn_label;