-- Revenue decomposition: Orders vs AOV contribution
SELECT
  year,
  month,
  year_month,
  orders,
  aov,
  revenue,
  revenue_mom_delta,
  delta_from_orders,
  delta_from_aov,
  (delta_from_orders + delta_from_aov) AS delta_sum,
  (revenue_mom_delta - (delta_from_orders + delta_from_aov)) AS residual
FROM marts.rev_driver_orders_aov_decomp
ORDER BY year_month;
