DROP VIEW IF EXISTS marts.kpi_repeat_purchase;

CREATE VIEW marts.kpi_repeat_purchase AS
WITH customer_month AS (
  SELECT
    dd.year,
    dd.month,
    (dd.year * 100 + dd.month) AS year_month,
    fs.customer_id,
    COUNT(DISTINCT fs.invoice_no) AS orders_in_month
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd ON dd.date_key = fs.date_key
  WHERE fs.is_return = FALSE
  GROUP BY dd.year, dd.month, fs.customer_id
)
SELECT
  year,
  month,
  year_month,
  COUNT(*) AS active_customers,
  COUNT(*) FILTER (WHERE orders_in_month >= 2) AS repeat_buyers,
  (COUNT(*) FILTER (WHERE orders_in_month >= 2))::numeric / NULLIF(COUNT(*), 0) AS repeat_rate
FROM customer_month
GROUP BY year, month, year_month;
