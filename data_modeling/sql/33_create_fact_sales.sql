DROP TABLE IF EXISTS dw.fact_sales CASCADE;

CREATE TABLE dw.fact_sales AS
SELECT
  c.invoice_no,
  d.date_key,
  c.customer_id,
  c.stock_code,
  c.quantity,
  c.unit_price,
  (c.quantity * c.unit_price) AS revenue,
  c.is_return
FROM staging.online_retail_clean c
JOIN dw.dim_date d
  ON d.date = c.invoice_ts::date
WHERE
  c.invoice_ts IS NOT NULL
  AND c.invoice_no IS NOT NULL
  AND c.customer_id IS NOT NULL
  AND c.stock_code IS NOT NULL
  AND c.quantity IS NOT NULL
  AND c.unit_price IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_fact_sales_date_key    ON dw.fact_sales(date_key);
CREATE INDEX IF NOT EXISTS idx_fact_sales_customer_id ON dw.fact_sales(customer_id);
CREATE INDEX IF NOT EXISTS idx_fact_sales_stock_code  ON dw.fact_sales(stock_code);
CREATE INDEX IF NOT EXISTS idx_fact_sales_invoice_no  ON dw.fact_sales(invoice_no);

SELECT COUNT(*) AS fact_sales_rows FROM dw.fact_sales;
