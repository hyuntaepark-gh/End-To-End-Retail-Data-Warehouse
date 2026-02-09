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
)
SELECT *
FROM cohort_customers
ORDER BY cohort_month, customer_segment, customer_id;
