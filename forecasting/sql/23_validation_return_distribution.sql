SELECT
    return_label,
    COUNT(*) AS row_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
FROM ml.feature_return_risk
GROUP BY return_label
ORDER BY return_label;