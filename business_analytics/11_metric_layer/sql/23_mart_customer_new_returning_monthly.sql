CREATE OR REPLACE VIEW dw.mart_customer_new_returning_monthly AS
WITH first_purchase AS (
  SELECT
    customer_id,
    MIN(year * 100 + month) AS first_ym
  FROM dw.v_sales_enriched
  WHERE is_return = false
  GROUP BY 1
),
txn AS (
  SELECT
    year, month,
    customer_id,
    (year * 100 + month) AS ym
  FROM dw.v_sales_enriched
  WHERE is_return = false
  GROUP BY 1,2,3
)
SELECT
  t.year,
  t.month,
  COUNT(DISTINCT CASE WHEN t.ym = f.first_ym THEN t.customer_id END) AS new_customers,
  COUNT(DISTINCT CASE WHEN t.ym > f.first_ym THEN t.customer_id END) AS returning_customers
FROM txn t
JOIN first_purchase f ON t.customer_id = f.customer_id
GROUP BY 1,2
ORDER BY 1,2;
