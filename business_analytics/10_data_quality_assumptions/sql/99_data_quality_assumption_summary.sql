WITH base AS (
  SELECT * FROM dw.v_sales_enriched
),
p AS (
  SELECT PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY revenue) AS p99_rev
  FROM base
  WHERE revenue IS NOT NULL
)
SELECT
  -- Missing customer_id
  ROUND(100.0 * COUNT(*) FILTER (WHERE customer_id IS NULL) / COUNT(*), 2) AS pct_missing_customer,

  -- Returns by invoice rule
  ROUND(
    100.0 * SUM(revenue) FILTER (WHERE invoice_no LIKE 'C%') / NULLIF(SUM(revenue), 0)
  , 2) AS return_revenue_ratio_pct,

  -- p99 revenue
  (SELECT p99_rev FROM p) AS p99_order_revenue,

  -- Top 1% revenue share
  ROUND(
    100.0 * SUM(revenue) FILTER (WHERE revenue >= (SELECT p99_rev FROM p))
    / NULLIF(SUM(revenue), 0)
  , 2) AS top1p_revenue_share_pct
FROM base;
