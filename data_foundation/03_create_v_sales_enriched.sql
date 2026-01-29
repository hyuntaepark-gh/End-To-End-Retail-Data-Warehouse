CREATE OR REPLACE VIEW dw.v_sales_enriched AS
SELECT
  f.*,
  d.date,
  d.year,
  d.month,
  d.quarter,
  c.country AS customer_country,
  p.description AS product_description
FROM dw.fact_sales f
JOIN dw.dim_date d ON d.date_key = f.date_key
LEFT JOIN dw.dim_customer c ON c.customer_id = f.customer_id
LEFT JOIN dw.dim_product p ON p.stock_code = f.stock_code;
