WITH seg_prod AS (
  SELECT
    s.customer_segment,
    dp.description,
    SUM(fs.revenue) AS revenue
  FROM dw.fact_sales fs
  JOIN marts.customer_segments s ON s.customer_id = fs.customer_id
  LEFT JOIN dw.dim_product dp ON dp.stock_code = fs.stock_code
  WHERE fs.is_return = FALSE
  GROUP BY s.customer_segment, dp.description
)
SELECT
  description,
  SUM(CASE WHEN customer_segment = 'VIP' THEN revenue END)
    / SUM(revenue) AS vip_revenue_share
FROM seg_prod
GROUP BY description
HAVING SUM(revenue) >= 5000
ORDER BY vip_revenue_share DESC;
