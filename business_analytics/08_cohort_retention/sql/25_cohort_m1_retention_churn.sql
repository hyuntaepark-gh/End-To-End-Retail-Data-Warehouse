WITH first_purchase AS (
  SELECT
    fs.customer_id,
    DATE_TRUNC('month', MIN(dd.date)) AS cohort_month
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON fs.date_key = dd.date_key
  WHERE fs.is_return = false
  GROUP BY 1
),
activity AS (
  SELECT
    fp.customer_id,
    fp.cohort_month,
    DATE_TRUNC('month', dd.date) AS active_month
  FROM first_purchase fp
  JOIN dw.fact_sales fs
    ON fs.customer_id = fp.customer_id
   AND fs.is_return = false
  JOIN dw.dim_date dd
    ON fs.date_key = dd.date_key
  WHERE DATE_TRUNC('month', dd.date)
        IN (fp.cohort_month, fp.cohort_month + INTERVAL '1 month')
),
cohort_counts AS (
  SELECT
    cohort_month,
    COUNT(DISTINCT CASE WHEN active_month = cohort_month THEN customer_id END) AS m0_customers,
    COUNT(DISTINCT CASE WHEN active_month = cohort_month + INTERVAL '1 month' THEN customer_id END) AS m1_customers
  FROM activity
  GROUP BY 1
)
SELECT
  cohort_month,
  m0_customers,
  m1_customers,
  ROUND(100.0 * m1_customers / NULLIF(m0_customers, 0), 2) AS m1_retention_pct,
  ROUND(100.0 * (1 - (m1_customers::numeric / NULLIF(m0_customers, 0))), 2) AS early_churn_pct
FROM cohort_counts
ORDER BY cohort_month;
