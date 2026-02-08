-- 1) Number of unique customers with non-return transactions
SELECT COUNT(DISTINCT customer_id) AS customers_non_return
FROM dw.fact_sales
WHERE is_return = FALSE;

-- 2) Number of unique customers in the customer segments table
SELECT COUNT(DISTINCT customer_id) AS customers_in_segments
FROM marts.customer_segments;

-- 3) Customers with non-return transactions but missing from the segments table
--    (used to validate segment assignment completeness)
SELECT COUNT(DISTINCT fs.customer_id) AS customers_missing_segment
FROM dw.fact_sales fs
LEFT JOIN marts.customer_segments s
  ON s.customer_id = fs.customer_id
WHERE fs.is_return = FALSE
  AND s.customer_id IS NULL;
