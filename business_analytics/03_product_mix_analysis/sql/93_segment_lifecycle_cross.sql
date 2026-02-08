WITH lifecycle AS (
  -- reuse lifecycle logic from 88 (simplified to stage per stock_code)
  WITH monthly AS (
    SELECT
      fs.stock_code,
      (dd.year * 100 + dd.month) AS year_month,
      SUM(fs.revenue) AS revenue
    FROM dw.fact_sales fs
    JOIN dw.dim_date dd ON dd.date_key = fs.date_key
    WHERE fs.is_return = FALSE
    GROUP BY fs.stock_code, (dd.year * 100 + dd.month)
  ),
  ranked AS (
    SELECT
      *,
      ROW_NUMBER() OVER (PARTITION BY stock_code ORDER BY year_month DESC) AS rn_desc,
      COUNT(*) OVER (PARTITION BY stock_code) AS active_months
    FROM monthly
  ),
  agg AS (
    SELECT
      stock_code,
      MAX(active_months) AS active_months,
      SUM(CASE WHEN rn_desc BETWEEN 1 AND 6 THEN revenue ELSE 0 END) AS last6_revenue,
      SUM(CASE WHEN rn_desc BETWEEN 7 AND 12 THEN revenue ELSE 0 END) AS prev6_revenue
    FROM ranked
    GROUP BY stock_code
  )
  SELECT
    stock_code,
    CASE
      WHEN active_months < 3 THEN 'New/Low-history'
      WHEN prev6_revenue = 0 AND last6_revenue > 0 THEN 'Growing'
      WHEN last6_revenue >= prev6_revenue * 1.10 THEN 'Growing'
      WHEN last6_revenue <= prev6_revenue * 0.90 THEN 'Declining'
      ELSE 'Mature/Stable'
    END AS lifecycle_stage
  FROM agg
),
seg_rev AS (
  SELECT
    s.customer_segment,
    fs.stock_code,
    SUM(fs.revenue) AS revenue
  FROM dw.fact_sales fs
  JOIN marts.customer_segments s
    ON s.customer_id = fs.customer_id
  WHERE fs.is_return = FALSE
  GROUP BY s.customer_segment, fs.stock_code
),
joined AS (
  SELECT
    sr.customer_segment,
    COALESCE(l.lifecycle_stage, 'Unclassified') AS lifecycle_stage,
    SUM(sr.revenue) AS revenue
  FROM seg_rev sr
  LEFT JOIN lifecycle l
    ON l.stock_code = sr.stock_code
  GROUP BY sr.customer_segment, COALESCE(l.lifecycle_stage, 'Unclassified')
),
totals AS (
  SELECT
    customer_segment,
    SUM(revenue) AS segment_revenue
  FROM joined
  GROUP BY customer_segment
)
SELECT
  j.customer_segment,
  j.lifecycle_stage,
  j.revenue,
  j.revenue / NULLIF(t.segment_revenue, 0) AS revenue_share
FROM joined j
JOIN totals t
  ON t.customer_segment = j.customer_segment
ORDER BY j.customer_segment, revenue_share DESC;
