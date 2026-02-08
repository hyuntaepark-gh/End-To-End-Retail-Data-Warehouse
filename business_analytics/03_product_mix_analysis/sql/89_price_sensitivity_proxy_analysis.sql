WITH monthly AS (
  SELECT
    fs.stock_code,
    COALESCE(dp.description, '(unknown)') AS description,
    (dd.year * 100 + dd.month) AS year_month,
    SUM(fs.quantity) AS units_sold,
    SUM(fs.revenue) AS revenue,
    SUM(fs.revenue)::numeric / NULLIF(SUM(fs.quantity), 0) AS avg_price
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
    SUM(CASE WHEN rn_desc BETWEEN 1 AND 6 THEN units_sold ELSE 0 END) AS last6_units,
    SUM(CASE WHEN rn_desc BETWEEN 7 AND 12 THEN units_sold ELSE 0 END) AS prev6_units,
    (SUM(CASE WHEN rn_desc BETWEEN 1 AND 6 THEN revenue ELSE 0 END))::numeric
      / NULLIF(SUM(CASE WHEN rn_desc BETWEEN 1 AND 6 THEN units_sold ELSE 0 END), 0) AS last6_avg_price,
    (SUM(CASE WHEN rn_desc BETWEEN 7 AND 12 THEN revenue ELSE 0 END))::numeric
      / NULLIF(SUM(CASE WHEN rn_desc BETWEEN 7 AND 12 THEN units_sold ELSE 0 END), 0) AS prev6_avg_price
  FROM ranked
  GROUP BY stock_code
),
calc AS (
  SELECT
    *,
    (last6_units - prev6_units) AS units_delta,
    (last6_avg_price - prev6_avg_price) AS price_delta,
    (last6_units::numeric / NULLIF(prev6_units, 0) - 1) AS units_growth,
    (last6_avg_price / NULLIF(prev6_avg_price, 0) - 1) AS price_growth,
    -- Elasticity proxy: %ΔUnits / %ΔPrice  (negative => demand drops when price rises)
    ( (last6_units::numeric / NULLIF(prev6_units, 0) - 1)
      / NULLIF((last6_avg_price / NULLIF(prev6_avg_price, 0) - 1), 0)
    ) AS elasticity_proxy
  FROM agg
)
SELECT
  stock_code,
  description,
  active_months,
  prev6_units,
  last6_units,
  prev6_avg_price,
  last6_avg_price,
  units_growth,
  price_growth,
  elasticity_proxy
FROM calc
WHERE active_months >= 8
  AND prev6_units >= 30
  AND prev6_avg_price IS NOT NULL
  AND last6_avg_price IS NOT NULL
ORDER BY elasticity_proxy NULLS LAST;
