SELECT
  stock_code,
  COUNT(*)      AS return_lines,
  SUM(revenue)  AS return_value
FROM dw.v_sales_enriched
WHERE invoice_no LIKE 'C%'
GROUP BY 1
ORDER BY return_value DESC
LIMIT 20;
