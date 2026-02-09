WITH sales AS (
  SELECT
    fs.customer_id,
    dd.date,
    fs.invoice_no,
    fs.revenue
  FROM dw.fact_sales fs
  JOIN dw.dim_date dd
    ON fs.date_key = dd.date_key
  WHERE fs.is_return = false
    AND fs.customer_id IS NOT NULL
),
rfm_base AS (
  SELECT
    customer_id,
    MAX(date) AS last_purchase_date,
    COUNT(DISTINCT invoice_no) AS frequency_orders,
    SUM(revenue) AS monetary_revenue
  FROM sales
  GROUP BY 1
),
rfm_scored AS (
  SELECT
    customer_id,
    (CURRENT_DATE - last_purchase_date) AS recency_days,
    frequency_orders,
    monetary_revenue,
    NTILE(5) OVER (ORDER BY (CURRENT_DATE - last_purchase_date) DESC) AS r_score, -- 최근일수록 점수 높게
    NTILE(5) OVER (ORDER BY frequency_orders) AS f_score,
    NTILE(5) OVER (ORDER BY monetary_revenue) AS m_score
  FROM rfm_base
)
SELECT
  customer_id,
  recency_days,
  frequency_orders,
  monetary_revenue,
  r_score, f_score, m_score,
  CASE
    WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
    WHEN r_score >= 4 AND (f_score >= 3 OR m_score >= 3) THEN 'Loyal'
    WHEN r_score <= 2 AND f_score >= 4 THEN 'At Risk'
    WHEN r_score <= 2 AND m_score >= 4 THEN 'Big Spenders (Dormant)'
    ELSE 'Regular'
  END AS segment
FROM rfm_scored;
