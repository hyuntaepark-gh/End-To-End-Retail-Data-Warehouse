DROP TABLE IF EXISTS dw.fact_sales;

CREATE TABLE dw.fact_sales AS
SELECT
  c.invoice_no,
  d.date_key,
  c.customer_id,
  c.stock_code,
  c.quantity,
  c.unit_price,
  c.quantity * c.unit_price AS revenue
FROM staging.online_retail_clean c
JOIN dw.dim_date d
  ON d.date = c.invoice_ts::date
WHERE
  c.invoice_ts IS NOT NULL
  AND c.quantity IS NOT NULL
  AND c.unit_price IS NOT NULL;
