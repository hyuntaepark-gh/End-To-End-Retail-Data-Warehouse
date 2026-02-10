SELECT
  SUM(revenue) AS total_revenue,
  SUM(revenue) FILTER (WHERE invoice_no LIKE 'C%') AS return_revenue,
  ROUND(
    100.0 * SUM(revenue) FILTER (WHERE invoice_no LIKE 'C%') / NULLIF(SUM(revenue), 0)
  , 2) AS return_revenue_ratio_pct
FROM dw.v_sales_enriched;
