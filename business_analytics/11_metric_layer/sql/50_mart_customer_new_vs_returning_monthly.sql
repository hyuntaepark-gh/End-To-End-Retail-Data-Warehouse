CREATE OR REPLACE VIEW dw.mart_customer_new_vs_returning_monthly AS
WITH first_purchase AS (
  SELECT
    customer_id,
    MIN(year * 100 + month) AS first_ym
  FROM dw.v_sales_enriched
  WHERE is_return = false
  GROUP BY customer_id
),

monthly_customers AS (
  SELECT
    year,
    month,
    customer_id,
    (year * 100 + month) AS ym
  FROM dw.v_sales_enriched
  WHERE is_return = false
  GROUP BY 1, 2, 3
)

SELECT
  m.year,
  m.month,
  COUNT(DISTINCT CASE WHEN m.ym = f.first_ym THEN m.customer_id END) AS new_customers,
  COUNT(DISTINCT CASE WHEN m.ym > f.first_ym THEN m.customer_id END) AS returning_customers,
  COUNT(DISTINCT m.customer_id) AS total_customers
FROM monthly_customers m
JOIN first_purchase f
  ON m.customer_id = f.customer_id
GROUP BY 1, 2
ORDER BY 1, 2;
