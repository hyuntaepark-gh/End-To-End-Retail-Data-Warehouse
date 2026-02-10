SELECT
  AVG(revenue) AS gross_aov,
  AVG(revenue) FILTER (WHERE revenue > 0) AS net_aov
FROM dw.v_sales_enriched;
