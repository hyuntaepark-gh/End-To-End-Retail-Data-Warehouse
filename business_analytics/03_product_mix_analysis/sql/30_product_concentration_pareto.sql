WITH product_rev AS (
  SELECT
    dp.description,
    SUM(fs.revenue) AS revenue
  FROM dw.fact_sales fs
  LEFT JOIN dw.dim_product dp
    ON dp.stock_code = fs.stock_code
  WHERE fs.is_return = FALSE
  GROUP BY dp.description
),
ranked AS (
  SELECT
    description,
    revenue,
    SUM(revenue) OVER () AS total_revenue,
    SUM(revenue) OVER (ORDER BY revenue DESC) AS cumulative_revenue
  FROM product_rev
)
SELECT
  description,
  revenue,
  cumulative_revenue / total_revenue AS cumulative_share
FROM ranked
ORDER BY revenue DESC;
