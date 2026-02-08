WITH product_rev AS (
  SELECT
    fs.stock_code,
    SUM(fs.revenue) AS revenue
  FROM dw.fact_sales fs
  WHERE fs.is_return = FALSE
  GROUP BY fs.stock_code
),
ranked AS (
  SELECT
    stock_code,
    revenue,
    ROW_NUMBER() OVER (ORDER BY revenue DESC) AS rn,
    SUM(revenue) OVER () AS total_revenue
  FROM product_rev
)
SELECT
  bucket,
  SUM(revenue) AS bucket_revenue,
  SUM(revenue) / NULLIF(MAX(total_revenue), 0) AS revenue_share
FROM (
  SELECT
    *,
    CASE
      WHEN rn = 1 THEN 'Top 1'
      WHEN rn <= 5 THEN 'Top 5'
      WHEN rn <= 10 THEN 'Top 10'
      WHEN rn <= 20 THEN 'Top 20'
      ELSE NULL
    END AS bucket
  FROM ranked
) t
WHERE bucket IS NOT NULL
GROUP BY bucket
ORDER BY
  CASE bucket
    WHEN 'Top 1' THEN 1
    WHEN 'Top 5' THEN 2
    WHEN 'Top 10' THEN 3
    WHEN 'Top 20' THEN 4
    ELSE 9
  END;
