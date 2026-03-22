CREATE OR REPLACE VIEW ml.train_feature_customer_churn AS
SELECT
    customer_id,
    total_orders,
    total_revenue,
    avg_order_revenue,
    recency_days,
    churn_label
FROM ml.feature_customer_churn
WHERE customer_id IS NOT NULL
  AND total_orders IS NOT NULL
  AND total_revenue IS NOT NULL
  AND recency_days IS NOT NULL;
  SELECT *
FROM ml.train_feature_customer_churn
LIMIT 50;