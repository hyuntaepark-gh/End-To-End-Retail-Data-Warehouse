DROP TABLE IF EXISTS staging.online_retail_clean;

CREATE TABLE staging.online_retail_clean AS
WITH base AS (
  SELECT
    NULLIF(trim(invoice_no), '')  AS invoice_no,
    NULLIF(trim(stock_code), '')  AS stock_code,
    NULLIF(trim(description), '') AS description,
    NULLIF(trim(customer_id), '') AS customer_id,
    NULLIF(trim(country), '')     AS country,

    CASE
      WHEN trim(quantity) ~ '^-?\d+(\.\d+)?$' THEN trim(quantity)::numeric
      ELSE NULL
    END AS quantity,

    CASE
      WHEN trim(unit_price) ~ '^-?\d+(\.\d+)?$' THEN trim(unit_price)::numeric
      ELSE NULL
    END AS unit_price,

    CASE
      WHEN invoice_date IS NULL OR trim(invoice_date) = '' THEN NULL
      ELSE to_timestamp(trim(invoice_date), 'YYYY-MM-DD HH24:MI')
    END AS invoice_ts

  FROM staging.online_retail_raw
)
SELECT
  *,
  (quantity < 0) AS is_return
FROM base;

-- sanity check
SELECT
  COUNT(*) AS clean_rows,
  MIN(invoice_ts) AS min_invoice_ts,
  MAX(invoice_ts) AS max_invoice_ts,
  SUM(CASE WHEN invoice_ts IS NULL THEN 1 ELSE 0 END) AS null_invoice_ts
FROM staging.online_retail_clean;
