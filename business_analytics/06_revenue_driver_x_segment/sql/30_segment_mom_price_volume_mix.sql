WITH m AS (
  SELECT
    DATE_TRUNC('month', dd.date)::date AS month,
    s.customer_segment,
    SUM(fs.quantity) AS units,
    SUM(fs.revenue)  AS revenue
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON dd.date_key = fs.date_key
  JOIN marts.customer_segments s
    ON s.customer_id = fs.customer_id
  WHERE fs.is_return = FALSE
  GROUP BY
    DATE_TRUNC('month', dd.date)::date,
    s.customer_segment
),
k AS (
  SELECT
    month,
    customer_segment,
    units,
    revenue,
    (revenue / NULLIF(units, 0)) AS avg_unit_price
  FROM m
),
w AS (
  SELECT
    *,
    LAG(units) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_units,
    LAG(avg_unit_price) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_price,
    LAG(revenue) OVER (PARTITION BY customer_segment ORDER BY month) AS prev_revenue
  FROM k
)
SELECT *
FROM w
ORDER BY customer_segment, month;
