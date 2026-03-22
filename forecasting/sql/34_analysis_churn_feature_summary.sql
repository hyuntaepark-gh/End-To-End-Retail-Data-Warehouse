SELECT
    churn_label,
    ROUND(AVG(total_orders), 2) AS avg_total_orders,
    ROUND(AVG(total_revenue), 2) AS avg_total_revenue,
    ROUND(AVG(avg_order_revenue), 2) AS avg_order_revenue,
    ROUND(AVG(recency_days), 2) AS avg_recency_days
FROM ml.feature_customer_churn
GROUP BY churn_label
ORDER BY churn_label;