DROP TABLE IF EXISTS dw.dim_product CASCADE;

CREATE TABLE dw.dim_product AS
WITH desc_rank AS (
  SELECT
    stock_code,
    description,
    COUNT(*) AS cnt,
    ROW_NUMBER() OVER (
      PARTITION BY stock_code
      ORDER BY COUNT(*) DESC, description
    ) AS rn
  FROM staging.online_retail_clean
  WHERE stock_code IS NOT NULL
    AND description IS NOT NULL
    AND trim(description) <> ''
  GROUP BY stock_code, description
),
best_desc AS (
  SELECT stock_code, description
  FROM desc_rank
  WHERE rn = 1
)
SELECT
  p.stock_code,
  COALESCE(b.description, 'Unknown') AS description
FROM (
  SELECT DISTINCT stock_code
  FROM staging.online_retail_clean
  WHERE stock_code IS NOT NULL
) p
LEFT JOIN best_desc b
  ON b.stock_code = p.stock_code;

ALTER TABLE dw.dim_product
  ADD CONSTRAINT pk_dim_product PRIMARY KEY (stock_code);

SELECT COUNT(*) AS dim_product_rows FROM dw.dim_product;
