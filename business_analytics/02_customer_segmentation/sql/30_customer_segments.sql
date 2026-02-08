WITH rfm AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY (CURRENT_DATE - MAX(dd.date)) ASC) AS r_score,
        NTILE(5) OVER (ORDER BY COUNT(DISTINCT fs.invoice_no) DESC) AS f_score,
        NTILE(5) OVER (ORDER BY SUM(fs.revenue) DESC) AS m_score
    FROM dw.fact_sales fs
    JOIN dw.dim_date dd
      ON dd.date_key = fs.date_key
    WHERE fs.is_return = FALSE
    GROUP BY customer_id
)
SELECT
    customer_id,
    r_score,
    f_score,
    m_score,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 4 AND f_score >= 3 THEN 'Loyal Customers'
        WHEN r_score <= 2 AND f_score >= 4 THEN 'At Risk'
        WHEN r_score = 1 THEN 'Churned'
        ELSE 'Regular'
    END AS customer_segment
FROM rfm;
