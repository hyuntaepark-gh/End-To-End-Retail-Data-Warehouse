DROP TABLE IF EXISTS staging.online_retail_clean;

CREATE TABLE staging.online_retail_clean AS
SELECT
  NULLIF(invoice_no, '')  AS invoice_no,
  NULLIF(stock_code, '')  AS stock_code,
  NULLIF(description, '') AS description,
  NULLIF(customer_id, '') AS customer_id,
  NULLIF(country, '')     AS country,

  -- keep original text
  NULLIF(invoice_date, '') AS invoice_date_raw,

  NULLIF(REGEXP_REPLACE(quantity, '[^0-9\-]', '', 'g'), '')::INT AS quantity,
  NULLIF(REGEXP_REPLACE(unit_price, '[^0-9\.]', '', 'g'), '')::NUMERIC(12,4) AS unit_price,

  CASE
    WHEN invoice_date ~ '^\d{1,2}/\d{1,2}/\d{4}\s+\d{1,2}:\d{2}$'
      THEN to_timestamp(invoice_date, 'DD/MM/YYYY HH24:MI')
    WHEN invoice_date ~ '^\d{4}-\d{2}-\d{2}'
      THEN invoice_date::timestamp
    ELSE NULL
  END AS invoice_ts,

  _loaded_at
FROM staging.online_retail_raw;

-- checks
SELECT COUNT(*) FROM staging.online_retail_clean;

SELECT
  COUNT(*) FILTER (WHERE invoice_ts IS NULL) AS null_invoice_ts,
  COUNT(*) FILTER (WHERE quantity IS NULL)   AS null_quantity,
  COUNT(*) FILTER (WHERE unit_price IS NULL) AS null_unit_price
FROM staging.online_retail_clean;

SELECT invoice_date_raw, invoice_ts
FROM staging.online_retail_clean
WHERE invoice_ts IS NULL
LIMIT 20;
