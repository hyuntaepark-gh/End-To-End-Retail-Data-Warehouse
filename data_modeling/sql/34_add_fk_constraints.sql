ALTER TABLE dw.fact_sales
  ADD CONSTRAINT fk_fact_date
  FOREIGN KEY (date_key) REFERENCES dw.dim_date(date_key);

ALTER TABLE dw.fact_sales
  ADD CONSTRAINT fk_fact_customer
  FOREIGN KEY (customer_id) REFERENCES dw.dim_customer(customer_id);

ALTER TABLE dw.fact_sales
  ADD CONSTRAINT fk_fact_product
  FOREIGN KEY (stock_code) REFERENCES dw.dim_product(stock_code);
