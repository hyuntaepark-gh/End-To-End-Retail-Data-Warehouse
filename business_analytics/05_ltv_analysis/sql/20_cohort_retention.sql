WITH base AS (
  SELECT
    fs.customer_id,
    DATE_TRUNC('month', dd.date)::date AS order_month
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON dd.date_key = fs.date_key
  WHERE fs.is_return = FALSE
  GROUP BY fs.customer_id, DATE_TRUNC('month', dd.date)::date
),
first_month AS (
  SELECT
    customer_id,
    MIN(order_month) AS cohort_month
  FROM base
  GROUP BY customer_id
),
activity AS (
  SELECT
    b.customer_id,
    f.cohort_month,
    b.order_month,
    (EXTRACT(YEAR FROM b.order_month) - EXTRACT(YEAR FROM f.cohort_month)) * 12
    + (EXTRACT(MONTH FROM b.order_month) - EXTRACT(MONTH FROM f.cohort_month)) AS cohort_index
  FROM base b
  JOIN first_month f
    ON f.customer_id = b.customer_id
),
cohort_size AS (
  SELECT
    cohort_month,
    COUNT(DISTINCT customer_id) AS cohort_customers
  FROM first_month
  GROUP BY cohort_month
)
SELECT
  a.cohort_month,
  a.cohort_index,
  COUNT(DISTINCT a.customer_id) AS active_customers,
  cs.cohort_customers,
  ROUND(100.0 * COUNT(DISTINCT a.customer_id) / NULLIF(cs.cohort_customers, 0), 2) AS retention_pct
FROM activity a
JOIN cohort_size cs
  ON cs.cohort_month = a.cohort_month
GROUP BY a.cohort_month, a.cohort_index, cs.cohort_customers
ORDER BY a.cohort_month, a.cohort_index;
