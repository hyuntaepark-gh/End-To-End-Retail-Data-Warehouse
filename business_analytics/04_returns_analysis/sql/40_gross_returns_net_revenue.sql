SELECT
  SUM(revenue) FILTER (WHERE invoice_no NOT LIKE 'C%') AS gross_sales,
  SUM(revenue) FILTER (WHERE invoice_no LIKE 'C%')     AS returns_value,
  SUM(revenue)                                         AS net_revenue
FROM dw.v_sales_enriched;
