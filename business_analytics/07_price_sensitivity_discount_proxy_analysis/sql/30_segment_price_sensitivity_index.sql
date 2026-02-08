WITH monthly AS (
  SELECT
    DATE_TRUNC('month', dd.date)::date AS month,
    s.customer_segment,
    SUM(fs.quantity) AS units,
    SUM(fs.revenue) AS revenue,
    SUM(fs.revenue) / NULLIF(SUM(fs.quantity), 0) AS avg_price
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON dd.date_key = fs.date_key
  JOIN marts.customer_segments s
    ON s.customer_id = fs.customer_id
  WHERE fs.is_return = FALSE
  GROUP BY
    DATE_TRUNC('month', dd.date)::date,
    s.customer_segment
),
changes AS (
  SELECT
    month,
    customer_segment,
    (avg_price - LAG(avg_price) OVER (PARTITION BY customer_segment ORDER BY month))
      / NULLIF(LAG(avg_price) OVER (PARTITION BY customer_segment ORDER BY month), 0) AS price_change_pct,
    (units - LAG(units) OVER (PARTITION BY customer_segment ORDER BY month))
      / NULLIF(LAG(units) OVER (PARTITION BY customer_segment ORDER BY month), 0) AS unit_change_pct
  FROM monthly
),
clean AS (
  SELECT *
  FROM changes
  WHERE price_change_pct IS NOT NULL
    AND unit_change_pct IS NOT NULL
    AND ABS(price_change_pct) > 0.0001
)
SELECT
  customer_segment,
  ROUND(AVG(ABS(unit_change_pct / price_change_pct)), 2) AS price_sensitivity_index,
  COUNT(*) AS months_used
FROM clean
GROUP BY customer_segment
ORDER BY price_sensitivity_index DESC;
