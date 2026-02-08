WITH p AS (
  SELECT
    DATE_TRUNC('month', dd.date)::date AS month,
    s.customer_segment,
    COALESCE(dp.description, '(unknown)') AS description,
    SUM(fs.revenue) AS revenue
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON dd.date_key = fs.date_key
  JOIN marts.customer_segments s
    ON s.customer_id = fs.customer_id
  LEFT JOIN dw.dim_product dp
    ON dp.stock_code = fs.stock_code
  WHERE fs.is_return = FALSE
  GROUP BY
    DATE_TRUNC('month', dd.date)::date,
    s.customer_segment,
    COALESCE(dp.description, '(unknown)')
),
seg_total AS (
  SELECT
    month,
    customer_segment,
    SUM(revenue) AS seg_revenue
  FROM p
  GROUP BY month, customer_segment
),
share AS (
  SELECT
    p.month,
    p.customer_segment,
    p.description,
    p.revenue,
    (p.revenue / NULLIF(t.seg_revenue, 0)) AS revenue_share
  FROM p
  JOIN seg_total t
    ON t.month = p.month
   AND t.customer_segment = p.customer_segment
)
SELECT *
FROM share
ORDER BY month, customer_segment, revenue DESC;
