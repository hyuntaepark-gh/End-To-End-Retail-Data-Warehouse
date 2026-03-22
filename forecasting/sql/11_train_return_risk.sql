CREATE OR REPLACE VIEW ml.train_feature_return_risk AS
SELECT
    invoice_no,
    customer_id,
    stock_code,
    quantity,
    unit_price,
    revenue,
    year,
    month,
    price_band,
    historical_return_rate,
    avg_product_revenue,
    avg_product_quantity,
    return_label
FROM ml.feature_return_risk
WHERE stock_code IS NOT NULL
  AND unit_price IS NOT NULL
  AND quantity IS NOT NULL
  AND revenue IS NOT NULL;
  SELECT *
FROM ml.train_feature_return_risk
LIMIT 50;