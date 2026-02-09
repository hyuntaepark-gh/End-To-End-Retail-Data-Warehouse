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
m0 AS (
  SELECT DISTINCT customer_id, cohort_month
  FROM first_purchase
),
m1 AS (
  SELECT DISTINCT fp.customer_id
  FROM first_purchase fp
  JOIN dw.fact_sales fs
    ON fs.customer_id = fp.customer_id
   AND fs.is_return = false
  JOIN dw.dim_date dd
    ON fs.date_key = dd.date_key
  WHERE DATE_TRUNC('month', dd.date) = fp.cohort_month + INTERVAL '1 month'
)
SELECT
  (SELECT COUNT(DISTINCT customer_id) FROM m0) AS total_new_customers_m0,
  (SELECT COUNT(DISTINCT customer_id) FROM m1) AS retained_to_m1_customers,
  ROUND(
    100.0 * (SELECT COUNT(DISTINCT customer_id) FROM m1)
    / NULLIF((SELECT COUNT(DISTINCT customer_id) FROM m0), 0),
    2
  ) AS m1_retention_pct,
  ROUND(
    100.0 * (1 - (
      (SELECT COUNT(DISTINCT customer_id) FROM m1)::numeric
      / NULLIF((SELECT COUNT(DISTINCT customer_id) FROM m0), 0)
    )),
    2
  ) AS early_churn_pct;
