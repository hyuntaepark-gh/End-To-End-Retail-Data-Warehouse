-- 1) date_key format sanity (expect YYYYMMDD)
SELECT
  MIN(date_key) AS min_date_key,
  MAX(date_key) AS max_date_key
FROM dw.fact_sales;

-- 2) Return share (by invoices and revenue)
SELECT
  COUNT(DISTINCT invoice_no) FILTER (WHERE is_return = true)::numeric
    / NULLIF(COUNT(DISTINCT invoice_no), 0) AS pct_return_invoices,
  SUM(revenue) FILTER (WHERE is_return = true)::numeric
    / NULLIF(SUM(revenue), 0) AS pct_return_revenue
FROM dw.fact_sales;

-- 3) KPI mart row count (should equal number of year-month combos)
SELECT COUNT(*) AS months_in_kpi_mart
FROM dw.mart_kpi_monthly;

-- 4) Spot check: latest month KPIs
SELECT *
FROM dw.mart_kpi_monthly
ORDER BY year DESC, month DESC
LIMIT 12;

-- 5) date_key format check (YYYYMMDD length)
SELECT
  COUNT(*) FILTER (WHERE date_key < 19000101 OR date_key > 21000101) AS bad_date_keys
FROM dw.fact_sales;

-- 6) revenue sanity (negative or extreme)
SELECT
  COUNT(*) FILTER (WHERE revenue < 0) AS negative_revenue_rows,
  PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY revenue) AS p99_revenue

FROM dw.fact_sales;

-- 7) Spot check: MoM / QoQ KPI sanity
SELECT
  year,
  month,
  orders,
  orders_mom_pct,
  revenue_mom_pct,
  revenue_qoq_pct
FROM dw.mart_kpi_monthly_mom_qoq
ORDER BY year DESC, month DESC
LIMIT 6;

-- 8) new vs returning customer counts
SELECT
  year,
  month,
  new_customers,
  returning_customers,
  total_customers
FROM dw.mart_customer_new_vs_returning_monthly
ORDER BY year DESC, month DESC
LIMIT 6;

