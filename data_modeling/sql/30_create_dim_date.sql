DROP TABLE IF EXISTS dw.dim_date CASCADE;

CREATE TABLE dw.dim_date AS
WITH bounds AS (
  SELECT
    MIN(invoice_ts::date) AS min_date,
    MAX(invoice_ts::date) AS max_date
  FROM staging.online_retail_clean
  WHERE invoice_ts IS NOT NULL
)
SELECT
  (EXTRACT(YEAR FROM d)::int * 10000
   + EXTRACT(MONTH FROM d)::int * 100
   + EXTRACT(DAY FROM d)::int) AS date_key,
  d AS date,
  EXTRACT(YEAR FROM d)::int AS year,
  EXTRACT(QUARTER FROM d)::int AS quarter,
  EXTRACT(MONTH FROM d)::int AS month,
  TO_CHAR(d, 'Month') AS month_name,
  EXTRACT(DAY FROM d)::int AS day,
  EXTRACT(DOW FROM d)::int AS day_of_week,
  TO_CHAR(d, 'Dy') AS day_name,
  (EXTRACT(ISODOW FROM d) IN (6,7)) AS is_weekend
FROM bounds b
CROSS JOIN generate_series(b.min_date, b.max_date, INTERVAL '1 day') AS d;

ALTER TABLE dw.dim_date
  ADD CONSTRAINT pk_dim_date PRIMARY KEY (date_key);

SELECT COUNT(*) AS dim_date_rows FROM dw.dim_date;
