INSERT INTO ml.prediction_monthly_sales (
    stock_code,
    year,
    month,
    actual_revenue,
    predicted_revenue,
    abs_error,
    ape,
    lower_ci,
    upper_ci,
    model_name
)
VALUES
('85123A', 2011, 12, 1200.00, 1150.00, 50.00, 4.17, 1050.00, 1250.00, 'xgboost_test'),
('71053', 2011, 12, 800.00, 860.00, 60.00, 7.50, 780.00, 940.00, 'xgboost_test');
SELECT *
FROM ml.prediction_monthly_sales;