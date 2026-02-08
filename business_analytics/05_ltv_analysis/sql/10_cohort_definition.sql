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
)
SELECT
  cohort_month,
  COUNT(*) AS customers
FROM first_month
GROUP BY cohort_month
ORDER BY cohort_month;
