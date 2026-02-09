WITH purchases AS (
  SELECT
    fs.customer_id,
    DATE_TRUNC('month', dd.date)::date AS order_month,
    fs.invoice_no
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON dd.date_key = fs.date_key
  WHERE fs.is_return = FALSE
  GROUP BY fs.customer_id, DATE_TRUNC('month', dd.date)::date, fs.invoice_no
),
cohort AS (
  SELECT
    customer_id,
    MIN(order_month) AS cohort_month
  FROM purchases
  GROUP BY customer_id
),
activity AS (
  SELECT DISTINCT
    c.cohort_month,
    p.customer_id,
    p.order_month,
    (
      EXTRACT(YEAR FROM p.order_month) * 12 + EXTRACT(MONTH FROM p.order_month)
      - (EXTRACT(YEAR FROM c.cohort_month) * 12 + EXTRACT(MONTH FROM c.cohort_month))
    )::int AS cohort_index
  FROM purchases p
  JOIN cohort c
    ON c.customer_id = p.customer_id
  WHERE p.order_month >= c.cohort_month
),
cohort_size AS (
  SELECT
    cohort_month,
    COUNT(DISTINCT customer_id) AS cohort_customers
  FROM cohort
  GROUP BY cohort_month
),
retention AS (
  SELECT
    a.cohort_month,
    a.cohort_index,
    COUNT(DISTINCT a.customer_id) AS active_customers
  FROM activity a
  GROUP BY a.cohort_month, a.cohort_index
)
SELECT
  r.cohort_month,
  r.cohort_index,
  cs.cohort_customers,
  r.active_customers,
  ROUND(r.active_customers::numeric / NULLIF(cs.cohort_customers, 0), 4) AS retention_rate
FROM retention r
JOIN cohort_size cs
  ON cs.cohort_month = r.cohort_month
ORDER BY r.cohort_month, r.cohort_index;
