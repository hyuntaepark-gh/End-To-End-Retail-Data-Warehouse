WITH sku AS (
  SELECT
    stock_code,

    SUM(CASE WHEN invoice_no NOT LIKE 'C%' THEN revenue ELSE 0 END) AS gross_revenue,
    SUM(CASE WHEN invoice_no LIKE 'C%' THEN revenue ELSE 0 END) AS return_loss,

    COUNT(*) FILTER (WHERE invoice_no NOT LIKE 'C%') AS sale_txn_cnt,
    COUNT(*) FILTER (WHERE invoice_no LIKE 'C%') AS return_txn_cnt
  FROM dw.v_sales_enriched
  GROUP BY 1
),
final AS (
  SELECT
    stock_code,
    gross_revenue,
    return_loss,
    (gross_revenue - return_loss) AS net_revenue,

    CASE WHEN sale_txn_cnt = 0 THEN 0
         ELSE return_txn_cnt::numeric / sale_txn_cnt
    END AS return_rate_txn,

    CASE WHEN gross_revenue = 0 THEN 0
         ELSE return_loss::numeric / gross_revenue
    END AS revenue_impact_pct
  FROM sku
)
SELECT *
FROM final
WHERE gross_revenue > 0
ORDER BY gross_revenue DESC, return_rate_txn DESC
LIMIT 50;
