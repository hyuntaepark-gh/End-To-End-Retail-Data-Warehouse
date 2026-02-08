DROP TABLE IF EXISTS raw.online_retail;

CREATE TABLE raw.online_retail (
  invoice_no   TEXT,
  stock_code   TEXT,
  description  TEXT,
  quantity     TEXT,
  invoice_date TEXT,   -- keep raw as text
  unit_price   TEXT,
  customer_id  TEXT,
  country      TEXT
);

-- quick check
SELECT COUNT(*) AS raw_rows FROM raw.online_retail;