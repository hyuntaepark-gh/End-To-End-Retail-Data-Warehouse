CREATE OR REPLACE VIEW dw.v_return_risk_by_order_value_decile AS
SELECT
  order_value_decile,
  COUNT(*) AS orders,
  COUNT(*) FILTER (WHERE revenue < 0) AS return_orders,
  ROUND(100.0 * COUNT(*) FILTER (WHERE revenue < 0) / COUNT(*), 2) AS return_rate_pct,
  ROUND(
    100.0 * ABS(SUM(revenue) FILTER (WHERE revenue < 0))
    / NULLIF(SUM(ABS(revenue)), 0),
    2
  ) AS return_revenue_share_pct
FROM (
  SELECT
    revenue,
    NTILE(10) OVER (ORDER BY revenue) AS order_value_decile
  FROM dw.v_sales_enriched
) t
GROUP BY order_value_decile;
