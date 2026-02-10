WITH sku AS (
  SELECT
    stock_code,
    SUM(CASE WHEN NOT is_return THEN revenue ELSE 0 END) AS gross_revenue,
    SUM(CASE WHEN is_return THEN ABS(revenue) ELSE 0 END) AS return_loss,
    COUNT(*) FILTER (WHERE NOT is_return) AS sale_txn_cnt,
    COUNT(*) FILTER (WHERE is_return) AS return_txn_cnt
  FROM dw.v_sales_enriched
  GROUP BY 1
),
metrics AS (
  SELECT
    stock_code,
    gross_revenue,
    return_loss,
    return_txn_cnt::numeric / NULLIF(sale_txn_cnt, 0) AS return_rate_txn,
    return_loss::numeric / NULLIF(gross_revenue, 0) AS revenue_impact_pct
  FROM sku
  WHERE gross_revenue >= 1000
    AND sale_txn_cnt >= 10
),
ranked AS (
  SELECT
    *,
    PERCENT_RANK() OVER (ORDER BY return_rate_txn) AS pr_return_rate,
    PERCENT_RANK() OVER (ORDER BY revenue_impact_pct) AS pr_impact
  FROM metrics
)
SELECT
  stock_code,
  gross_revenue,
  return_loss,
  return_rate_txn,
  revenue_impact_pct,
  (pr_return_rate - pr_impact) AS mismatch_score
FROM ranked
ORDER BY ABS(pr_return_rate - pr_impact) DESC
LIMIT 50;
