WITH monthly_product AS (
  SELECT
    fs.stock_code,
    dp.description,
    DATE_TRUNC('month', dd.date)::date AS month,
    SUM(fs.revenue) AS revenue
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON dd.date_key = fs.date_key
  LEFT JOIN dw.dim_product dp
    ON dp.stock_code = fs.stock_code
  WHERE fs.is_return = FALSE
  GROUP BY
    fs.stock_code,
    dp.description,
    DATE_TRUNC('month', dd.date)::date
)
SELECT
  stock_code,
  description,
  COUNT(DISTINCT month) AS active_months,
  SUM(revenue) AS total_revenue,
  AVG(revenue) AS avg_monthly_revenue
FROM monthly_product
GROUP BY stock_code, description
ORDER BY total_revenue DESC;
