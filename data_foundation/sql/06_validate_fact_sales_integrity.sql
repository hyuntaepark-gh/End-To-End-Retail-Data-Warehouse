SELECT
  COUNT(*) FILTER (WHERE revenue <= 0) AS non_positive_revenue_rows,
  COUNT(*) AS total_rows
FROM dw.fact_sales;
SELECT
  COUNT(*) FILTER (WHERE date_key IS NULL) AS null_date_key_rows
FROM dw.fact_sales;
