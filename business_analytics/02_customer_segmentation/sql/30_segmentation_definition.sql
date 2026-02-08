SELECT
  customer_segment,
  COUNT(*) AS customers
FROM marts.customer_segments
GROUP BY customer_segment
ORDER BY customers DESC;

