WITH ranked AS (
  SELECT
    s.customer_segment,
    COALESCE(dp.description, '(unknown)') AS product_description,
    SUM(fs.revenue) AS revenue,
    ROW_NUMBER() OVER (
      PARTITION BY s.customer_segment
      ORDER BY SUM(fs.revenue) DESC
    ) AS rn
  FROM dw.fact_sales fs
  JOIN marts.customer_segments s
    ON s.customer_id = fs.customer_id
  LEFT JOIN dw.dim_product dp
    ON dp.stock_code = fs.stock_code
  WHERE fs.is_return = FALSE
  GROUP BY s.customer_segment, COALESCE(dp.description, '(unknown)')
)
SELECT
  customer_segment,
  product_description,
  revenue
FROM ranked
WHERE rn <= 10
ORDER BY customer_segment, revenue DESC;
