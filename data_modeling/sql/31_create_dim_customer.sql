DROP TABLE IF EXISTS dw.dim_customer CASCADE;

CREATE TABLE dw.dim_customer AS
WITH country_rank AS (
  SELECT
    customer_id,
    country,
    COUNT(*) AS cnt,
    ROW_NUMBER() OVER (
      PARTITION BY customer_id
      ORDER BY COUNT(*) DESC, country
    ) AS rn
  FROM staging.online_retail_clean
  WHERE customer_id IS NOT NULL
    AND country IS NOT NULL
    AND trim(country) <> ''
  GROUP BY customer_id, country
),
best_country AS (
  SELECT customer_id, country
  FROM country_rank
  WHERE rn = 1
)
SELECT
  c.customer_id,
  COALESCE(b.country, 'Unknown') AS country
FROM (
  SELECT DISTINCT customer_id
  FROM staging.online_retail_clean
  WHERE customer_id IS NOT NULL
) c
LEFT JOIN best_country b
  ON b.customer_id = c.customer_id;

ALTER TABLE dw.dim_customer
  ADD CONSTRAINT pk_dim_customer PRIMARY KEY (customer_id);

CREATE INDEX IF NOT EXISTS idx_dim_customer_country
  ON dw.dim_customer(country);

SELECT COUNT(*) AS dim_customer_rows FROM dw.dim_customer;
