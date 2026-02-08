-- MoM changes for revenue, orders, and AOV
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
)
SELECT
  year,
  month,
  year_month,
  revenue,
  revenue - LAG(revenue) OVER (ORDER BY year_month) AS revenue_mom_delta,
  orders,
  orders - LAG(orders) OVER (ORDER BY year_month) AS orders_mom_delta,
  aov,
  aov - LAG(aov) OVER (ORDER BY year_month) AS aov_mom_delta
FROM m
ORDER BY year_month;
