WITH base AS (
  SELECT
    dc.country,
    dd.year,
    dd.month,
    (dd.year*100 + dd.month) AS year_month,
    COUNT(DISTINCT fs.invoice_no) AS orders,
    SUM(fs.revenue) AS revenue,
    SUM(fs.revenue) / NULLIF(COUNT(DISTINCT fs.invoice_no), 0) AS aov
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd ON dd.date_key = fs.date_key
  JOIN dw.dim_customer dc ON dc.customer_id = fs.customer_id
  WHERE fs.is_return = FALSE
  GROUP BY dc.country, dd.year, dd.month
),
lagged AS (
  SELECT
    *,
    LAG(revenue) OVER (PARTITION BY country ORDER BY year_month) AS prev_revenue,
    LAG(orders)  OVER (PARTITION BY country ORDER BY year_month) AS prev_orders,
    LAG(aov)     OVER (PARTITION BY country ORDER BY year_month) AS prev_aov
  FROM base
)
SELECT
  country,
  year_month,
  revenue - prev_revenue AS revenue_delta,
  (orders - prev_orders) * ((aov + prev_aov)/2) AS delta_from_orders,
  (aov - prev_aov) * ((orders + prev_orders)/2) AS delta_from_aov
FROM lagged
ORDER BY country, year_month;
