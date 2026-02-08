WITH orders AS (
  SELECT
    fs.customer_id,
    COUNT(DISTINCT fs.invoice_no) AS orders,
    MIN(dd.date) AS first_purchase_date,
    MAX(dd.date) AS last_purchase_date,
    COUNT(DISTINCT DATE_TRUNC('month', dd.date)::date) AS active_months
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON dd.date_key = fs.date_key
  WHERE fs.is_return = FALSE
  GROUP BY fs.customer_id
)
SELECT
  customer_id,
  orders,
  active_months,
  ROUND(orders::numeric / NULLIF(active_months, 0), 3) AS orders_per_active_month,
  first_purchase_date,
  last_purchase_date
FROM orders
ORDER BY orders DESC;
