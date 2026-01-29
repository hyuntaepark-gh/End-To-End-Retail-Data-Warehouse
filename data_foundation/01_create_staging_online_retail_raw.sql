DROP TABLE IF EXISTS staging.online_retail_raw;

CREATE TABLE staging.online_retail_raw (
    invoice_no     TEXT,
    stock_code     TEXT,
    description    TEXT,
    quantity       TEXT,
    invoice_date   TEXT,
    unit_price     TEXT,
    customer_id    TEXT,
    country        TEXT,
    _loaded_at     TIMESTAMP NOT NULL DEFAULT NOW()
);
