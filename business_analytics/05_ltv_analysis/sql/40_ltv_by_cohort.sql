WITH sales_monthly AS (
  SELECT
    fs.customer_id,
    DATE_TRUNC('month', dd.date)::date AS order_month,
    SUM(fs.revenue) AS revenue
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
  FROM sales_monthly
  GROUP BY customer_id
),
cohort_sales AS (
  SELECT
    f.cohort_month,
    s.order_month,
    (EXTRACT(YEAR FROM s.order_month) - EXTRACT(YEAR FROM f.cohort_month)) * 12
    + (EXTRACT(MONTH FROM s.order_month) - EXTRACT(MONTH FROM f.cohort_month)) AS cohort_index,
    SUM(s.revenue) AS cohort_revenue
  FROM sales_monthly s
  JOIN first_month f
    ON f.customer_id = s.customer_id
  GROUP BY f.cohort_month, s.order_month, cohort_index
),
cohort_size AS (
  SELECT
    cohort_month,
    COUNT(*) AS customers
  FROM first_month
  GROUP BY cohort_month
),
final AS (
  SELECT
    cs.cohort_month,
    cs.cohort_index,
    cs.cohort_revenue,
    sz.customers,
    SUM(cs.cohort_revenue) OVER (
      PARTITION BY cs.cohort_month
      ORDER BY cs.cohort_index
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
  FROM cohort_sales cs
  JOIN cohort_size sz
    ON sz.cohort_month = cs.cohort_month
)
SELECT
  cohort_month,
  cohort_index,
  cohort_revenue,
  customers,
  cumulative_revenue,
  ROUND(cumulative_revenue / NULLIF(customers, 0), 2) AS cumulative_ltv_per_customer
FROM final
ORDER BY cohort_month, cohort_index;
