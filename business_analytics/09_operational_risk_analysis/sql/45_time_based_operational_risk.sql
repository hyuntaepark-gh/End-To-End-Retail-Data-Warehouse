WITH sku_time AS (
  SELECT
    year,
    month,
    stock_code,
    SUM(CASE WHEN NOT is_return THEN revenue ELSE 0 END) AS gross_revenue,
    SUM(CASE WHEN is_return THEN ABS(revenue) ELSE 0 END) AS return_loss,
    COUNT(*) FILTER (WHERE NOT is_return) AS sale_txn_cnt,
    COUNT(*) FILTER (WHERE is_return) AS return_txn_cnt
  FROM dw.v_sales_enriched
  GROUP BY 1,2,3
),
metrics AS (
  SELECT
    year,
    month,
    stock_code,
    return_txn_cnt::numeric / NULLIF(sale_txn_cnt,0) AS return_rate_txn,
    return_loss::numeric / NULLIF(gross_revenue,0) AS revenue_impact_pct
  FROM sku_time
  WHERE gross_revenue >= 500
)
SELECT
  year,
  month,
  COUNT(*) AS sku_count,
  COUNT(*) FILTER (
    WHERE return_rate_txn >= 0.10
      AND revenue_impact_pct >= 0.10
  ) AS high_risk_skus
FROM metrics
GROUP BY 1,2
ORDER BY year, month;
