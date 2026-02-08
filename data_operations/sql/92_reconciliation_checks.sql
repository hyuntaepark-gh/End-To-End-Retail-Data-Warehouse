WITH staging_sum AS (
  SELECT SUM(quantity * unit_price) AS staging_revenue
  FROM staging.online_retail_clean
  WHERE invoice_ts IS NOT NULL
    AND invoice_no IS NOT NULL
    AND stock_code IS NOT NULL
    AND customer_id IS NOT NULL
    AND quantity IS NOT NULL
    AND unit_price IS NOT NULL
),
fact_sum AS (
  SELECT SUM(revenue) AS fact_revenue
  FROM dw.fact_sales
)
SELECT
  s.staging_revenue,
  f.fact_revenue,
  (s.staging_revenue - f.fact_revenue) AS diff
FROM staging_sum s
CROSS JOIN fact_sum f;
