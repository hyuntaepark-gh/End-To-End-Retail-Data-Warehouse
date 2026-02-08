SELECT COUNT(*) FROM staging.online_retail_raw;
SELECT
  SUM(CASE WHEN invoice_no IS NULL OR trim(invoice_no) = '' THEN 1 ELSE 0 END) AS null_invoice_no,
  SUM(CASE WHEN stock_code IS NULL OR trim(stock_code) = '' THEN 1 ELSE 0 END) AS null_stock_code,
  SUM(CASE WHEN customer_id IS NULL OR trim(customer_id) = '' THEN 1 ELSE 0 END) AS null_customer_id,
  SUM(CASE WHEN invoice_date IS NULL OR trim(invoice_date) = '' THEN 1 ELSE 0 END) AS null_invoice_date
FROM staging.online_retail_raw;