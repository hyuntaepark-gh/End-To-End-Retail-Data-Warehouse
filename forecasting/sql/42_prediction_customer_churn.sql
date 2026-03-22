INSERT INTO ml.prediction_customer_churn (
    customer_id,
    actual_churn_label,
    predicted_churn_probability,
    predicted_churn_label,
    model_name
)
VALUES
(17850, 0, 0.22, 0, 'xgboost_test'),
(13047, 1, 0.81, 1, 'xgboost_test');
SELECT *
FROM ml.prediction_customer_churn;