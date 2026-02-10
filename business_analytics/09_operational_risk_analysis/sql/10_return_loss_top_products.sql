WITH sku AS (
  SELECT
    stock_code,
    SUM(CASE WHEN invoice_no LIKE 'C%' THEN revenue ELSE 0 END) AS return_loss,
    SUM(CASE WHEN invoice_no NOT LIKE 'C%' THEN revenue ELSE 0 END) AS gross_revenue
  FROM dw.v_sales_enriched
  GROUP BY 1
),
final AS (
  SELECT
    stock_code,
    return_loss,
    gross_revenue,
    (gross_revenue - return_loss) AS net_revenue,
    CASE WHEN gross_revenue = 0 THEN 0
         ELSE return_loss::numeric / gross_revenue
    END AS revenue_impact_pct
  FROM sku
)
SELECT *
FROM final
WHERE gross_revenue > 0
ORDER BY return_loss DESC
LIMIT 20;
