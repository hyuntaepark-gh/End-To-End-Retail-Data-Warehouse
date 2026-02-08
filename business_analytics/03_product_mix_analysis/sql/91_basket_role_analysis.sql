WITH order_rev AS (
  SELECT
    fs.invoice_no,
    SUM(fs.revenue) AS order_revenue
  FROM dw.fact_sales fs
  WHERE fs.is_return = FALSE
  GROUP BY fs.invoice_no
),
overall AS (
  SELECT AVG(order_revenue) AS overall_aov
  FROM order_rev
),
product_orders AS (
  SELECT
    fs.stock_code,
    COUNT(DISTINCT fs.invoice_no) AS orders_with_product
  FROM dw.fact_sales fs
  WHERE fs.is_return = FALSE
  GROUP BY fs.stock_code
),
product_aov AS (
  SELECT
    fs.stock_code,
    AVG(orv.order_revenue) AS aov_when_present
  FROM dw.fact_sales fs
  JOIN order_rev orv
    ON orv.invoice_no = fs.invoice_no
  WHERE fs.is_return = FALSE
  GROUP BY fs.stock_code
)
SELECT
  po.stock_code,
  COALESCE(dp.description, '(unknown)') AS description,
  po.orders_with_product,
  pa.aov_when_present,
  o.overall_aov,
  (pa.aov_when_present - o.overall_aov) AS aov_uplift
FROM product_orders po
JOIN product_aov pa
  ON pa.stock_code = po.stock_code
CROSS JOIN overall o
LEFT JOIN dw.dim_product dp
  ON dp.stock_code = po.stock_code
WHERE po.orders_with_product >= 50
ORDER BY aov_uplift DESC;
