SELECT
  COUNT(*) AS total_rows,
  COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_rows,
  ROUND(
    100.0 * COUNT(*) FILTER (WHERE customer_id IS NULL) / COUNT(*)
  , 2) AS pct_missing_customer
FROM dw.v_sales_enriched;
