-- Revenue sanity (non-return rows should be >= 0 typically)
SELECT
  COUNT(*) FILTER (WHERE is_return = FALSE AND revenue < 0) AS neg_revenue_non_return,
  COUNT(*) FILTER (WHERE unit_price <= 0) AS non_positive_unit_price,
  COUNT(*) FILTER (WHERE quantity = 0) AS zero_quantity
FROM dw.fact_sales;

-- Date range sanity
SELECT
  MIN(dd.date) AS min_date,
  MAX(dd.date) AS max_date
FROM dw.fact_sales fs
JOIN dw.dim_date dd ON dd.date_key = fs.date_key;
