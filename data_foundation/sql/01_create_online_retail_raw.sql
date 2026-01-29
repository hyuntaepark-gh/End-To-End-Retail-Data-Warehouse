CREATE TABLE IF NOT EXISTS staging.online_retail_raw (
    invoice_no    TEXT,
    stock_code    TEXT,
    description   TEXT,
    quantity      INTEGER,
    invoice_date  TIMESTAMP,
    unit_price    NUMERIC(12,4),
    customer_id   TEXT,
    country       TEXT,
    _loaded_at    TIMESTAMP NOT NULL DEFAULT NOW()
);
