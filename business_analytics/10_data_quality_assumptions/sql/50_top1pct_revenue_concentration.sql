WITH p AS (
  SELECT
    PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY revenue) AS p99_rev
  FROM dw.v_sales_enriched
  WHERE revenue IS NOT NULL
),
x AS (
  SELECT
    SUM(revenue) AS total_revenue,
    SUM(revenue) FILTER (WHERE revenue >= (SELECT p99_rev FROM p)) AS top1p_revenue,
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE revenue >= (SELECT p99_rev FROM p)) AS top1p_rows
  FROM dw.v_sales_enriched
)
SELECT
  total_rows,
  top1p_rows,
  ROUND(100.0 * top1p_rows / NULLIF(total_rows,0), 2) AS top1p_rows_pct,
  total_revenue,
  top1p_revenue,
  ROUND(100.0 * top1p_revenue / NULLIF(total_revenue,0), 2) AS top1p_revenue_pct
FROM x;
