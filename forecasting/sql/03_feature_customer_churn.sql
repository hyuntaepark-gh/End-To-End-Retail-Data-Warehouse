CREATE OR REPLACE VIEW ml.feature_customer_churn AS
WITH customer_base AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS total_orders,
        SUM(revenue) AS total_revenue,
        AVG(revenue) AS avg_order_revenue,
        MAX(TO_DATE(date_key::text, 'YYYYMMDD')) AS last_purchase_date
    FROM dw.v_sales_enriched
    WHERE customer_id IS NOT NULL
      AND is_return = false
    GROUP BY customer_id
),
max_date AS (
    SELECT
        MAX(TO_DATE(date_key::text, 'YYYYMMDD')) AS max_purchase_date
    FROM dw.v_sales_enriched
    WHERE is_return = false
)
SELECT
    c.customer_id,
    c.total_orders,
    c.total_revenue,
    c.avg_order_revenue,
    c.last_purchase_date,
    m.max_purchase_date,
    (m.max_purchase_date - c.last_purchase_date) AS recency_days,
    CASE
        WHEN (m.max_purchase_date - c.last_purchase_date) > 60 THEN 1
        ELSE 0
    END AS churn_label
FROM customer_base c
CROSS JOIN max_date m;
SELECT *
FROM ml.feature_customer_churn
LIMIT 50;