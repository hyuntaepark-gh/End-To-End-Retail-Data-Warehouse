SELECT
  stock_code,
  SUM(quantity) AS units,
  SUM(revenue)  AS revenue
FROM dw.v_sales_enriched
GROUP BY 1
ORDER BY revenue DESC;
