-- Table exist check
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'staging'
  AND table_name = 'online_retail_raw';

-- check row count
SELECT COUNT(*) 
FROM staging.online_retail_raw;
