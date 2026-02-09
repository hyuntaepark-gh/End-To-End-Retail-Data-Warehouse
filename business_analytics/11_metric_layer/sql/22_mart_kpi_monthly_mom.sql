CREATE OR REPLACE VIEW dw.mart_kpi_monthly_mom AS
WITH base AS (
  SELECT
    year, month,
    orders, customers, revenue, aov,
    (year * 100 + month) AS ym
  FROM dw.mart_kpi_monthly
),
lagged AS (
  SELECT
    *,
    LAG(orders)   OVER (ORDER BY ym) AS orders_prev,
    LAG(customers)OVER (ORDER BY ym) AS customers_prev,
    LAG(revenue)  OVER (ORDER BY ym) AS revenue_prev,
    LAG(aov)      OVER (ORDER BY ym) AS aov_prev
  FROM base
)
SELECT
  year, month,
  orders, customers, revenue, aov,
  (orders - orders_prev) AS orders_mom_abs,
  (orders - orders_prev)::numeric / NULLIF(orders_prev, 0) AS orders_mom_pct,
  (revenue - revenue_prev) AS revenue_mom_abs,
  (revenue - revenue_prev)::numeric / NULLIF(revenue_prev, 0) AS revenue_mom_pct,
  (aov - aov_prev) AS aov_mom_abs,
  (aov - aov_prev)::numeric / NULLIF(aov_prev, 0) AS aov_mom_pct
FROM lagged
ORDER BY year, month;
