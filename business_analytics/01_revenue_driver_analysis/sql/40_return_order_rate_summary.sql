SELECT
  COUNT(DISTINCT invoice_no) FILTER (WHERE invoice_no LIKE 'C%') AS return_orders,
  COUNT(DISTINCT invoice_no)                                     AS total_orders,
  ROUND(
    COUNT(DISTINCT invoice_no) FILTER (WHERE invoice_no LIKE 'C%')::numeric
    / NULLIF(COUNT(DISTINCT invoice_no), 0),
    4
  ) AS return_order_rate
FROM dw.v_sales_enriched;
