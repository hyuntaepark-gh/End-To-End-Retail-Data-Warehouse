SELECT
    price_band,
    COUNT(*) AS row_count,
    ROUND(AVG(return_label::numeric), 4) AS return_rate
FROM ml.feature_return_risk
GROUP BY price_band
ORDER BY price_band;