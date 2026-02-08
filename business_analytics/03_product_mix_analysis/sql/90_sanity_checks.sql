-- Revenue consistency check
SELECT
  SUM(revenue) AS total_revenue
FROM dw.fact_sales
WHERE is_return = FALSE;
