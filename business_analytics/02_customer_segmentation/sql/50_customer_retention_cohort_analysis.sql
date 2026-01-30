WITH customer_months AS (
  SELECT DISTINCT
    customer_id,
    DATE_TRUNC('month', date)::date AS active_month
  FROM dw.v_sales_enriched
  WHERE customer_id IS NOT NULL
),
cohorts AS (
  SELECT
    customer_id,
    MIN(active_month) AS cohort_month
  FROM customer_months
  GROUP BY 1
),
cohort_activity AS (
  SELECT
    c.cohort_month,
    m.active_month,
    (DATE_PART('year', m.active_month) - DATE_PART('year', c.cohort_month)) * 12
    + (DATE_PART('month', m.active_month) - DATE_PART('month', c.cohort_month)) AS month_index,
    COUNT(DISTINCT m.customer_id) AS active_customers
  FROM customer_months m
  JOIN cohorts c ON c.customer_id = m.customer_id
  GROUP BY 1, 2, 3
),
cohort_size AS (
  SELECT
    cohort_month,
    COUNT(DISTINCT customer_id) AS cohort_customers
  FROM cohorts
  GROUP BY 1
)
SELECT
  a.cohort_month,
  a.month_index,
  a.active_customers,
  s.cohort_customers,
  ROUND(a.active_customers::numeric / NULLIF(s.cohort_customers, 0), 4) AS retention_rate
FROM cohort_activity a
JOIN cohort_size s USING (cohort_month)
WHERE a.month_index BETWEEN 0 AND 12
ORDER BY 1, 2;
