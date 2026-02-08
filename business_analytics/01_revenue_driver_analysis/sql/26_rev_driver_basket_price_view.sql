DROP VIEW IF EXISTS marts.rev_driver_basket_price;

CREATE VIEW marts.rev_driver_basket_price AS
WITH base AS (
  SELECT
    dd.year,
    dd.month,
    (dd.year * 100 + dd.month) AS year_month,
    fs.invoice_no,
    fs.quantity,
    fs.unit_price,
    fs.revenue
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd ON dd.date_key = fs.date_key
  WHERE fs.is_return = FALSE
),
m AS (
  SELECT
    year,
    month,
    year_month,
    COUNT(DISTINCT invoice_no) AS orders,
    SUM(revenue) AS revenue,
    SUM(revenue) / NULLIF(COUNT(DISTINCT invoice_no), 0) AS aov,
    SUM(quantity)::numeric / NULLIF(COUNT(DISTINCT invoice_no), 0) AS items_per_order,
    SUM(revenue)::numeric / NULLIF(SUM(quantity), 0) AS avg_price_per_item
  FROM base
  GROUP BY year, month, year_month
)
SELECT
  *,
  (items_per_order * avg_price_per_item) AS aov_reconstructed
FROM m;
