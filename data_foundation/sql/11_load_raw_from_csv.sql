-- NOTE: Update the file path for your environment.
-- If you're using psql, this works:
-- \copy raw.online_retail FROM 'C:/path/to/OnlineRetail.csv' CSV HEADER;

-- Server-side COPY example (requires server access to file):
-- COPY raw.online_retail FROM '/path/to/OnlineRetail.csv' WITH (FORMAT csv, HEADER true);

SELECT 'Update the CSV path in this file before running.' AS note;