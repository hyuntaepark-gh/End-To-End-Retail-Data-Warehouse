CREATE OR REPLACE VIEW ml.feature_return_risk AS
SELECT
    invoice_no,
    customer_id,
    stock_code,
    quantity,
    unit_price,
    revenue,
    year,
    month,
    CASE
        WHEN unit_price < 2 THEN 'low'
        WHEN unit_price < 5 THEN 'mid'
        ELSE 'high'
    END AS price_band,
    AVG(CASE WHEN is_return THEN 1.0 ELSE 0.0 END)
        OVER (PARTITION BY stock_code) AS historical_return_rate,
    AVG(revenue) OVER (PARTITION BY stock_code) AS avg_product_revenue,
    AVG(quantity) OVER (PARTITION BY stock_code) AS avg_product_quantity,
    CASE WHEN is_return THEN 1 ELSE 0 END AS return_label
FROM dw.v_sales_enriched;
SELECT *
FROM ml.feature_return_risk
LIMIT 50;