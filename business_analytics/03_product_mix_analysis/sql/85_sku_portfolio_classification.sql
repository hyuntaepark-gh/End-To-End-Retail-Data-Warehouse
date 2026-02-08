WITH base_sales AS (
  SELECT
    fs.stock_code,
    COALESCE(dp.description, '(unknown)') AS description,
    fs.invoice_no,
    fs.is_return,
    dd.year * 100 + dd.month AS year_month,
    fs.revenue
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON dd.date_key = fs.date_key
  LEFT JOIN dw.dim_product dp
    ON dp.stock_code = fs.stock_code
),
sku_monthly AS (
  -- monthly revenue only for non-return transactions
  SELECT
    stock_code,
    description,
    year_month,
    SUM(revenue) AS revenue
  FROM base_sales
  WHERE is_return = FALSE
  GROUP BY stock_code, description, year_month
),
sku_core AS (
  SELECT
    stock_code,
    description,
    COUNT(*) AS active_months,
    SUM(revenue) AS total_revenue,
    SUM(revenue)::numeric / NULLIF(COUNT(*), 0) AS avg_monthly_revenue
  FROM sku_monthly
  GROUP BY stock_code, description
),
sku_returns AS (
  SELECT
    stock_code,
    COUNT(DISTINCT CASE WHEN is_return THEN invoice_no END) AS return_orders,
    COUNT(DISTINCT invoice_no) AS total_orders,
    (COUNT(DISTINCT CASE WHEN is_return THEN invoice_no END))::numeric
      / NULLIF(COUNT(DISTINCT invoice_no), 0) AS return_rate
  FROM base_sales
  GROUP BY stock_code
),
scored AS (
  SELECT
    c.stock_code,
    c.description,
    c.active_months,
    c.total_revenue,
    c.avg_monthly_revenue,
    r.return_rate,
    NTILE(5) OVER (ORDER BY c.avg_monthly_revenue DESC) AS revenue_strength_q,
    NTILE(5) OVER (ORDER BY c.active_months DESC) AS availability_q
  FROM sku_core c
  LEFT JOIN sku_returns r
    ON r.stock_code = c.stock_code
),
classified AS (
  SELECT
    *,
    CASE
      WHEN availability_q >= 4 AND revenue_strength_q >= 4 THEN 'Core'
      WHEN availability_q <= 2 AND revenue_strength_q >= 4 THEN 'Seasonal/Spiky'
      WHEN revenue_strength_q <= 2 THEN 'Low-impact'
      ELSE 'Mid-tier'
    END AS sku_type
  FROM scored
)
SELECT
  sku_type,
  stock_code,
  description,
  active_months,
  total_revenue,
  avg_monthly_revenue,
  return_rate
FROM classified
ORDER BY
  CASE sku_type
    WHEN 'Core' THEN 1
    WHEN 'Mid-tier' THEN 2
    WHEN 'Seasonal/Spiky' THEN 3
    WHEN 'Low-impact' THEN 4
    ELSE 5
  END,
  total_revenue DESC;