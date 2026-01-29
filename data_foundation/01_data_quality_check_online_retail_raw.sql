-- Data Quality Check: NULL or Empty Value Counts
SELECT
  SUM(CASE WHEN invoice_no IS NULL OR invoice_no = '' THEN 1 ELSE 0 END) AS null_invoice_no,
  SUM(CASE WHEN stock_code IS NULL OR stock_code = '' THEN 1 ELSE 0 END) AS null_stock_code,
  SUM(CASE WHEN invoice_date IS NULL OR invoice_date = '' THEN 1 ELSE 0 END) AS null_invoice_date
FROM staging.online_retail_raw;

-- Sample Check: Inspect invoice_date values before type conversion
SELECT invoice_date
FROM staging.online_retail_raw
WHERE invoice_date IS NOT NULL
LIMIT 20;
