SELECT
  SUM(revenue) AS total_revenue,
  SUM(revenue) FILTER (WHERE revenue < 0) AS negative_revenue,
  ROUND(
    100.0 * ABS(SUM(revenue) FILTER (WHERE revenue < 0)) / NULLIF(SUM(revenue), 0)
  , 2) AS neg_revenue_share_pct
FROM dw.v_sales_enriched;
