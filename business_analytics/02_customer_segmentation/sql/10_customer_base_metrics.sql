-- Customer-level base metrics
SELECT
    fs.customer_id,
    COUNT(DISTINCT fs.invoice_no) AS orders,
    SUM(fs.revenue)               AS revenue,
    SUM(fs.revenue) / NULLIF(COUNT(DISTINCT fs.invoice_no), 0) AS aov,
    MIN(dd.date) AS first_purchase_date,
    MAX(dd.date) AS last_purchase_date
FROM dw.fact_sales fs
JOIN dw.dim_date dd
  ON dd.date_key = fs.date_key
WHERE fs.is_return = FALSE
GROUP BY fs.customer_id;
