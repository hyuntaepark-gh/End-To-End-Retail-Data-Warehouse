WITH sku AS (
  SELECT
    stock_code,
    SUM(CASE WHEN invoice_no NOT LIKE 'C%' THEN revenue ELSE 0 END) AS gross_revenue,
    SUM(CASE WHEN invoice_no LIKE 'C%' THEN ABS(revenue) ELSE 0 END) AS return_loss,
    COUNT(*) FILTER (WHERE invoice_no NOT LIKE 'C%') AS sale_txn_cnt,
    COUNT(*) FILTER (WHERE invoice_no LIKE 'C%') AS return_txn_cnt
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
  WHERE gross_revenue >= 1000        -- 🔥 규모 보정
    AND sale_txn_cnt >= 10
)
SELECT *
FROM metrics
WHERE return_rate_txn >= 0.10
  AND revenue_impact_pct >= 0.10
ORDER BY return_loss DESC;
