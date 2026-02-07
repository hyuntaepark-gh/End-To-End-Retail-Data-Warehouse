SELECT
  stock_code,
  COALESCE(product_description, '(unknown)') AS product_description,
  SUM(quantity)                              AS units_sold,
  SUM(revenue)                               AS revenue
FROM dw.v_sales_enriched
GROUP BY 1, 2
ORDER BY revenue DESC
LIMIT 20;
