WITH customer_metrics AS (
    SELECT
        fs.customer_id,
        COUNT(DISTINCT fs.invoice_no) AS frequency,
        SUM(fs.revenue)               AS monetary,
        MAX(dd.date)                  AS last_purchase_date
    FROM dw.fact_sales fs
    JOIN dw.dim_date dd
      ON dd.date_key = fs.date_key
    WHERE fs.is_return = FALSE
    GROUP BY fs.customer_id
),
rfm AS (
    SELECT
        customer_id,
        (CURRENT_DATE - last_purchase_date) AS recency,
        frequency,
        monetary
    FROM customer_metrics
),
scored AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency ASC)   AS r_score,
        NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary DESC)  AS m_score
    FROM rfm
)
SELECT
    *,
    (r_score + f_score + m_score) AS rfm_score
FROM scored;
