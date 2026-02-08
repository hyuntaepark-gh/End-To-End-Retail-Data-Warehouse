WITH segments AS (
    SELECT
        customer_id,
        CASE
            WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
            WHEN r_score >= 4 AND f_score >= 3 THEN 'Loyal Customers'
            WHEN r_score <= 2 AND f_score >= 4 THEN 'At Risk'
            WHEN r_score = 1 THEN 'Churned'
            ELSE 'Regular'
        END AS customer_segment
    FROM (
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
    ) t
)
SELECT
    s.customer_segment,
    COUNT(DISTINCT fs.customer_id) AS customers,
    SUM(fs.revenue)                AS revenue,
    SUM(fs.revenue) /
        SUM(SUM(fs.revenue)) OVER () AS revenue_share
FROM dw.fact_sales fs
JOIN segments s
  ON s.customer_id = fs.customer_id
WHERE fs.is_return = FALSE
GROUP BY s.customer_segment
ORDER BY revenue DESC;
