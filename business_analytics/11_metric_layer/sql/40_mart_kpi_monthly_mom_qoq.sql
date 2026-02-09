CREATE OR REPLACE VIEW dw.mart_kpi_monthly_mom_qoq AS
WITH base AS (
  SELECT
    year,
    month,
    orders,
    customers,
    revenue,
    aov,
    (year * 100 + month) AS ym
  FROM dw.mart_kpi_monthly
),

lagged AS (
  SELECT
    *,
    -- MoM (previous month)
    LAG(orders)   OVER (ORDER BY ym) AS orders_prev_m,
    LAG(customers)OVER (ORDER BY ym) AS customers_prev_m,
    LAG(revenue)  OVER (ORDER BY ym) AS revenue_prev_m,
    LAG(aov)      OVER (ORDER BY ym) AS aov_prev_m,

    -- QoQ (previous quarter = 3 months ago)
    LAG(orders, 3)   OVER (ORDER BY ym) AS orders_prev_q,
    LAG(customers,3)OVER (ORDER BY ym) AS customers_prev_q,
    LAG(revenue, 3)  OVER (ORDER BY ym) AS revenue_prev_q,
    LAG(aov, 3)      OVER (ORDER BY ym) AS aov_prev_q
  FROM base
)

SELECT
  year,
  month,

  orders,
  customers,
  revenue,
  aov,

  -- =====================
  -- MoM Absolute Change
  -- =====================
  orders - orders_prev_m     AS orders_mom_abs,
  customers - customers_prev_m AS customers_mom_abs,
  revenue - revenue_prev_m   AS revenue_mom_abs,
  aov - aov_prev_m           AS aov_mom_abs,

  -- =====================
  -- MoM Percentage Change
  -- =====================
  (orders - orders_prev_m)::numeric
    / NULLIF(orders_prev_m, 0)     AS orders_mom_pct,
  (customers - customers_prev_m)::numeric
    / NULLIF(customers_prev_m, 0)  AS customers_mom_pct,
  (revenue - revenue_prev_m)::numeric
    / NULLIF(revenue_prev_m, 0)    AS revenue_mom_pct,
  (aov - aov_prev_m)::numeric
    / NULLIF(aov_prev_m, 0)        AS aov_mom_pct,

  -- =====================
  -- QoQ Percentage Change
  -- =====================
  (orders - orders_prev_q)::numeric
    / NULLIF(orders_prev_q, 0)     AS orders_qoq_pct,
  (revenue - revenue_prev_q)::numeric
    / NULLIF(revenue_prev_q, 0)    AS revenue_qoq_pct

FROM lagged
ORDER BY year, month;