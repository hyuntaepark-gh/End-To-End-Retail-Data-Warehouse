DROP VIEW IF EXISTS marts.rev_driver_orders_aov_decomp;

CREATE VIEW marts.rev_driver_orders_aov_decomp AS
WITH m AS (
  SELECT
    dd.year,
    dd.month,
    (dd.year * 100 + dd.month) AS year_month,
    COUNT(DISTINCT fs.invoice_no) AS orders,
    SUM(fs.revenue) AS revenue,
    SUM(fs.revenue) / NULLIF(COUNT(DISTINCT fs.invoice_no), 0) AS aov
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd ON dd.date_key = fs.date_key
  WHERE fs.is_return = FALSE
  GROUP BY dd.year, dd.month
),
lagged AS (
  SELECT
    *,
    LAG(orders)  OVER (ORDER BY year_month) AS prev_orders,
    LAG(aov)     OVER (ORDER BY year_month) AS prev_aov,
    LAG(revenue) OVER (ORDER BY year_month) AS prev_revenue
  FROM m
)
SELECT
  year,
  month,
  year_month,
  orders,
  aov,
  revenue,
  (revenue - prev_revenue) AS revenue_mom_delta,
  (orders - prev_orders) * ((aov + prev_aov) / 2) AS delta_from_orders,
  (aov - prev_aov) * ((orders + prev_orders) / 2) AS delta_from_aov
FROM lagged;
