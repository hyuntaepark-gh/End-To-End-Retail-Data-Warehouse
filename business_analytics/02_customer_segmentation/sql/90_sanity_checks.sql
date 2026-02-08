-- Check 1: Segment coverage
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM dw.fact_sales
WHERE is_return = FALSE;

-- Check 2: Segment revenue consistency
SELECT
    SUM(revenue) AS revenue_from_segments
FROM (
    SELECT
        fs.customer_id,
        SUM(fs.revenue) AS revenue
    FROM dw.fact_sales fs
    WHERE fs.is_return = FALSE
    GROUP BY fs.customer_id
) t;
