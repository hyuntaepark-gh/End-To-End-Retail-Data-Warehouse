DROP TABLE IF EXISTS dw.dim_customer;

CREATE TABLE dw.dim_customer AS
SELECT DISTINCT
  customer_id,
  country
FROM staging.online_retail_clean
WHERE customer_id IS NOT NULL;
DROP TABLE IF EXISTS dw.dim_product;

CREATE TABLE dw.dim_product AS
SELECT DISTINCT
  stock_code,
  description
FROM staging.online_retail_clean
WHERE stock_code IS NOT NULL;
