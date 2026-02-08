SELECT
    dp.description,
    COUNT(DISTINCT CASE WHEN fs.is_return THEN fs.invoice_no END) AS return_orders,
    COUNT(DISTINCT fs.invoice_no) AS total_orders,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN fs.is_return THEN fs.invoice_no END)
        / NULLIF(COUNT(DISTINCT fs.invoice_no), 0),
        2
    ) AS return_rate_pct
FROM dw.fact_sales fs
LEFT JOIN dw.dim_product dp
    ON dp.stock_code = fs.stock_code
GROUP BY dp.description
HAVING COUNT(DISTINCT fs.invoice_no) >= 50
ORDER BY return_rate_pct DESC;
