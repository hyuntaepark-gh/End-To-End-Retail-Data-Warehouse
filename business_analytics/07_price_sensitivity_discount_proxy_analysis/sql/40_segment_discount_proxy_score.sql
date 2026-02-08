WITH monthly AS (
  SELECT
    DATE_TRUNC('month', dd.date)::date AS month,
    s.customer_segment,
    SUM(fs.quantity) AS units,
    SUM(fs.revenue) AS revenue,
    SUM(fs.revenue) / NULLIF(SUM(fs.quantity), 0) AS avg_price
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd ON dd.date_key = fs.date_key
  JOIN marts.customer_segments s ON s.customer_id = fs.customer_id
  WHERE fs.is_return = FALSE
  GROUP BY
    DATE_TRUNC('month', dd.date)::date,
    s.customer_segment
),
changes AS (
  SELECT
    month,
    customer_segment,
    avg_price,
    (avg_price - LAG(avg_price) OVER (PARTITION BY customer_segment ORDER BY month))
      / NULLIF(LAG(avg_price) OVER (PARTITION BY customer_segment ORDER BY month), 0) AS price_change_pct
  FROM monthly
),
clean AS (
  SELECT *
  FROM changes
  WHERE price_change_pct IS NOT NULL
    AND ABS(price_change_pct) > 0.0001
)
SELECT
  customer_segment,
  COUNT(*) AS months_used,
  SUM(CASE WHEN price_change_pct < 0 THEN 1 ELSE 0 END) AS price_drop_months,
  ROUND(AVG(CASE WHEN price_change_pct < 0 THEN ABS(price_change_pct) END), 4) AS avg_drop_depth,
  ROUND( (SUM(CASE WHEN price_change_pct < 0 THEN 1 ELSE 0 END)::numeric / COUNT(*))
        * COALESCE(AVG(CASE WHEN price_change_pct < 0 THEN ABS(price_change_pct) END), 0)
  , 4) AS discount_proxy_score
FROM clean
GROUP BY customer_segment
ORDER BY discount_proxy_score DESC;
