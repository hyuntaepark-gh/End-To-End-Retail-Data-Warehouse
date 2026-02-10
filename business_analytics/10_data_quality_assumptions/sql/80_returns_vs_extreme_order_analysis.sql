WITH p AS (
  SELECT
    PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY revenue) AS p99_rev
  FROM dw.v_sales_enriched
  WHERE revenue IS NOT NULL
),
labeled AS (
  SELECT
    *,
    CASE
      WHEN revenue >= (SELECT p99_rev FROM p) THEN 'Top 1% Orders'
      ELSE 'Remaining 99% Orders'
    END AS order_value_group
  FROM dw.v_sales_enriched
)
SELECT
  order_value_group,
  COUNT(*) AS total_orders,
  COUNT(*) FILTER (WHERE revenue < 0) AS return_orders,
  ROUND(
    100.0 * COUNT(*) FILTER (WHERE revenue < 0)
    / NULLIF(COUNT(*), 0)
  , 2) AS return_rate_pct,
  ROUND(
    100.0 * ABS(SUM(revenue) FILTER (WHERE revenue < 0))
    / NULLIF(SUM(ABS(revenue)), 0)
  , 2) AS return_value_share_pct
FROM labeled
GROUP BY order_value_group
ORDER BY order_value_group;
