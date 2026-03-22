INSERT INTO ml.prediction_return_risk (
    invoice_no,
    customer_id,
    stock_code,
    actual_return_label,
    predicted_return_probability,
    predicted_return_label,
    model_name
)
VALUES
('536365', 17850, '85123A', 0, 0.18, 0, 'logreg_test'),
('536366', 13047, '71053', 1, 0.77, 1, 'logreg_test');
SELECT *
FROM ml.prediction_return_risk;