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
)
SELECT *
FROM cohort
ORDER BY cohort_month, customer_id;
