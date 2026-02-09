CREATE OR REPLACE VIEW dw.v_sales_enriched AS
SELECT
  invoice_no,
  customer_id,
  stock_code,
  quantity,
  unit_price,
  revenue,
  date_key,
  (date_key / 10000)::int AS year,
  ((date_key / 100) % 100)::int AS month,
  is_return
FROM dw.fact_sales;
