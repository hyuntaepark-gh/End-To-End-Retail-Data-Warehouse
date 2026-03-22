SELECT
    MIN(recency_days) AS min_recency_days,
    MAX(recency_days) AS max_recency_days,
    ROUND(AVG(recency_days), 2) AS avg_recency_days
FROM ml.feature_customer_churn;