WITH dataset_end AS (
  SELECT MAX(d.date) AS end_date
  FROM dw.fact_sales fs
  JOIN dw.dim_date d ON d.date_key = fs.date_key
  WHERE fs.is_return = FALSE
),
customer_last AS (
  SELECT
    s.customer_segment,
    fs.customer_id,
    MAX(d.date) AS last_purchase_date
  FROM dw.fact_sales fs
  JOIN dw.dim_date d ON d.date_key = fs.date_key
  JOIN marts.customer_segments s ON s.customer_id = fs.customer_id
  WHERE fs.is_return = FALSE
  GROUP BY s.customer_segment, fs.customer_id
)
SELECT
  c.customer_segment,
  AVG((e.end_date - c.last_purchase_date)) AS avg_recency_days,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (e.end_date - c.last_purchase_date)) AS p75_recency_days
FROM customer_last c
CROSS JOIN dataset_end e
GROUP BY c.customer_segment
ORDER BY avg_recency_days DESC;
