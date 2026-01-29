DROP TABLE IF EXISTS dw.dim_product;

CREATE TABLE dw.dim_product AS
SELECT DISTINCT
  stock_code,
  description
FROM staging.online_retail_clean
WHERE stock_code IS NOT NULL;

SELECT COUNT(*) FROM dw.dim_product;
