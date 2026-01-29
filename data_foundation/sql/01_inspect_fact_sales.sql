SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'dw'
  AND table_name = 'fact_sales';
SELECT COUNT(*) AS total_rows
FROM dw.fact_sales;
SELECT *
FROM dw.fact_sales
LIMIT 10;
