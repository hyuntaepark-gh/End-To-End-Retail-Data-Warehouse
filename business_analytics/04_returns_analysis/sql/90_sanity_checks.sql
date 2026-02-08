SELECT
  COUNT(*) AS total_rows,
  COUNT(*) FILTER (WHERE is_return) AS return_rows
FROM dw.fact_sales;
