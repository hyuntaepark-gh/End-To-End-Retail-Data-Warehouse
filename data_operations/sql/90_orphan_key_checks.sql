-- Orphan date keys
SELECT COUNT(*) AS orphan_date_keys
FROM dw.fact_sales fs
LEFT JOIN dw.dim_date dd ON dd.date_key = fs.date_key
WHERE dd.date_key IS NULL;

-- Orphan customers
SELECT COUNT(*) AS orphan_customers
FROM dw.fact_sales fs
LEFT JOIN dw.dim_customer dc ON dc.customer_id = fs.customer_id
WHERE dc.customer_id IS NULL;

-- Orphan products
SELECT COUNT(*) AS orphan_products
FROM dw.fact_sales fs
LEFT JOIN dw.dim_product dp ON dp.stock_code = fs.stock_code
WHERE dp.stock_code IS NULL;