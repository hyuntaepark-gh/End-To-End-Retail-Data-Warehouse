-- Revenue contribution by customer segment
SELECT
  segment,
  COUNT(DISTINCT customer_id) AS customers,
  SUM(revenue)                AS revenue,
  ROUND(
    SUM(revenue) / SUM(SUM(revenue)) OVER () * 100,
    2
  ) AS revenue_pct
FROM dw.v_customer_segments
GROUP BY segment
ORDER BY revenue DESC;