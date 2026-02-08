WITH monthly AS (
  SELECT
    fs.stock_code,
    COALESCE(dp.description, '(unknown)') AS description,
    (dd.year * 100 + dd.month) AS year_month,
    SUM(fs.revenue) AS revenue
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd ON dd.date_key = fs.date_key
  LEFT JOIN dw.dim_product dp ON dp.stock_code = fs.stock_code
  WHERE fs.is_return = FALSE
  GROUP BY fs.stock_code, COALESCE(dp.description, '(unknown)'), (dd.year * 100 + dd.month)
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY stock_code ORDER BY year_month DESC) AS rn_desc,
    COUNT(*) OVER (PARTITION BY stock_code) AS active_months
  FROM monthly
),
agg AS (
  SELECT
    stock_code,
    MAX(description) AS description,
    MAX(active_months) AS active_months,
    SUM(revenue) AS total_revenue,
    SUM(CASE WHEN rn_desc BETWEEN 1 AND 6 THEN revenue ELSE 0 END) AS last6_revenue,
    SUM(CASE WHEN rn_desc BETWEEN 7 AND 12 THEN revenue ELSE 0 END) AS prev6_revenue,
    MAX(CASE WHEN rn_desc = 1 THEN year_month END) AS latest_year_month
  FROM ranked
  GROUP BY stock_code
),
classified AS (
  SELECT
    *,
    CASE
      WHEN active_months < 3 THEN 'New/Low-history'
      WHEN prev6_revenue = 0 AND last6_revenue > 0 THEN 'Growing'
      WHEN last6_revenue >= prev6_revenue * 1.10 THEN 'Growing'
      WHEN last6_revenue <= prev6_revenue * 0.90 THEN 'Declining'
      ELSE 'Mature/Stable'
    END AS lifecycle_stage
  FROM agg
)
SELECT
  lifecycle_stage,
  stock_code,
  description,
  active_months,
  total_revenue,
  prev6_revenue,
  last6_revenue,
  (last6_revenue - prev6_revenue) AS delta_last6_vs_prev6,
  latest_year_month
FROM classified
ORDER BY
  CASE lifecycle_stage
    WHEN 'Growing' THEN 1
    WHEN 'Mature/Stable' THEN 2
    WHEN 'Declining' THEN 3
    WHEN 'New/Low-history' THEN 4
    ELSE 9
  END,
  total_revenue DESC;