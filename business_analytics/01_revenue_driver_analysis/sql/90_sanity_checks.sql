-- Check 1: No missing months
SELECT COUNT(*) AS months_cnt
FROM (
  SELECT DISTINCT year_month
  FROM marts.rev_driver_orders_aov_decomp
) t;

-- Check 2: Revenue consistency between marts
SELECT
  m.year_month,
  m.revenue AS revenue_from_kpi,
  d.revenue AS revenue_from_decomp,
  (m.revenue - d.revenue) AS diff
FROM marts.kpi_monthly_revenue m
JOIN marts.rev_driver_orders_aov_decomp d
  ON d.year_month = m.year_month
ORDER BY m.year_month;

-- Check 3: Residual sanity (should be small)
SELECT
  year_month,
  revenue_mom_delta,
  (delta_from_orders + delta_from_aov) AS explained_delta,
  (revenue_mom_delta - (delta_from_orders + delta_from_aov)) AS residual
FROM marts.rev_driver_orders_aov_decomp
ORDER BY year_month;
