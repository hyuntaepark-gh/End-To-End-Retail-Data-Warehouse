WITH p AS (
  SELECT PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY revenue) AS cap
  FROM dw.v_sales_enriched
)
SELECT
  AVG(LEAST(revenue, (SELECT cap FROM p))) AS capped_aov
FROM dw.v_sales_enriched;
