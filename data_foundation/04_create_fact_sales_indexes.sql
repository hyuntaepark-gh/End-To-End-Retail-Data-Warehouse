CREATE INDEX IF NOT EXISTS idx_fact_sales_date_key ON dw.fact_sales(date_key);
CREATE INDEX IF NOT EXISTS idx_fact_sales_customer_id ON dw.fact_sales(customer_id);
CREATE INDEX IF NOT EXISTS idx_fact_sales_stock_code ON dw.fact_sales(stock_code);
