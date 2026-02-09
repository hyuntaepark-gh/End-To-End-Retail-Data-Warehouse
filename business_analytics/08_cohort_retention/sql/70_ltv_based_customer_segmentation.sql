WITH customer_revenue AS (
  SELECT
    fs.customer_id,
    SUM(fs.revenue) AS lifetime_revenue
  FROM dw.fact_sales fs
  WHERE fs.is_return = false
    AND fs.customer_id IS NOT NULL
  GROUP BY 1
),
segmented AS (
  SELECT
    customer_id,
    lifetime_revenue,
    NTILE(3) OVER (ORDER BY lifetime_revenue) AS revenue_tier
  FROM customer_revenue
)
SELECT
  customer_id,
  lifetime_revenue,
  CASE revenue_tier
    WHEN 1 THEN 'Low'
    WHEN 2 THEN 'Mid'
    WHEN 3 THEN 'High'
  END AS segment
FROM segmented;
