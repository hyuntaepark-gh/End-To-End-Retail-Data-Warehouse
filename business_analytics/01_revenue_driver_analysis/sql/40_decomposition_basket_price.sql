-- AOV decomposition: basket size vs price per item
SELECT
  year,
  month,
  year_month,
  orders,
  revenue,
  aov,
  items_per_order,
  avg_price_per_item,
  aov_reconstructed,
  (aov - aov_reconstructed) AS reconstruction_diff
FROM marts.rev_driver_basket_price
ORDER BY year_month;
