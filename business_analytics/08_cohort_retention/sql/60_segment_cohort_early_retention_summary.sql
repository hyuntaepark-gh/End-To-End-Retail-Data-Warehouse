WITH base AS (
  WITH purchases AS (
    SELECT
      fs.customer_id,
      fs.invoice_no,
      DATE_TRUNC('month', dd.date)::date AS order_month
    FROM dw.fact_sales fs
    JOIN dw.dim_date dd
      ON dd.date_key = fs.date_key
    WHERE fs.is_return = FALSE
    GROUP BY fs.customer_id, fs.invoice_no, DATE_TRUNC('month', dd.date)::date
  ),
  first_order AS (
    SELECT
      customer_id,
      MIN(order_month) AS cohort_month
    FROM purchases
    GROUP BY customer_id
  ),
  cohort_customers AS (
    SELECT
      f.customer_id,
      f.cohort_month,
      s.customer_segment
    FROM first_order f
    JOIN marts.customer_segments s
      ON s.customer_id = f.customer_id
  ),
  activity AS (
    SELECT DISTINCT
      c.cohort_month,
      c.customer_segment,
      p.customer_id,
      (
        EXTRACT(YEAR FROM p.order_month) * 12 + EXTRACT(MONTH FROM p.order_month)
        - (EXTRACT(YEAR FROM c.cohort_month) * 12 + EXTRACT(MONTH FROM c.cohort_month))
      )::int AS cohort_index
    FROM purchases p
    JOIN cohort_customers c
      ON c.customer_id = p.customer_id
    WHERE p.order_month >= c.cohort_month
  ),
  cohort_size AS (
    SELECT
      cohort_month,
      customer_segment,
      COUNT(DISTINCT customer_id) AS cohort_customers
    FROM cohort_customers
    GROUP BY cohort_month, customer_segment
  ),
  retention AS (
    SELECT
      cohort_month,
      customer_segment,
      cohort_index,
      COUNT(DISTINCT customer_id) AS active_customers
    FROM activity
    GROUP BY cohort_month, customer_segment, cohort_index
  )
  SELECT
    r.cohort_month,
    r.customer_segment,
    r.cohort_index,
    cs.cohort_customers,
    r.active_customers::numeric / NULLIF(cs.cohort_customers, 0) AS retention_rate
  FROM retention r
  JOIN cohort_size cs
    ON cs.cohort_month = r.cohort_month
   AND cs.customer_segment = r.customer_segment
)
SELECT
  cohort_month,
  customer_segment,
  MAX(cohort_customers) AS cohort_customers,
  ROUND(MAX(CASE WHEN cohort_index = 1 THEN retention_rate END), 4) AS retention_m1,
  ROUND(MAX(CASE WHEN cohort_index = 2 THEN retention_rate END), 4) AS retention_m2,
  ROUND(MAX(CASE WHEN cohort_index = 3 THEN retention_rate END), 4) AS retention_m3
FROM base
GROUP BY cohort_month, customer_segment
ORDER BY cohort_month, customer_segment;
