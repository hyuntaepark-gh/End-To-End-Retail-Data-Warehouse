# 📂 SQL Files

This folder contains SQL scripts used to generate forecasting and revenue scenario input datasets from the data warehouse.

All SQL files are based on `dw.v_sales_enriched` and are designed to create clean, exportable monthly datasets for Python analysis.

---

## Files

### 1. 01_monthly_orders.sql

Generates a monthly order-level aggregation dataset.

**Purpose**
- Create monthly order counts
- Build the base input for forecasting models
- Export result to `orders_monthly.csv`

**Output columns**
- `month`
- `orders`

---

### 2. 02_monthly_orders_timeseries.sql

Generates a time-series-ready version of monthly orders.

**Purpose**
- Prepare a clean monthly time series
- Ensure chronological ordering for forecasting notebooks
- Support baseline and SARIMA modeling

**Output columns**
- `month`
- `orders`

---

### 3. 03_monthly_kpi.sql

Generates a monthly KPI dataset for revenue scenario analysis.

**Purpose**
- Create monthly revenue and order metrics
- Calculate average order value (AOV)
- Build the input dataset for scenario-based revenue forecasting
- Export result to `monthly_kpi.csv`

**Output columns**
- `month`
- `revenue`
- `orders`
- `aov`

---

## Data Flow

`dw.v_sales_enriched`
→ `01_monthly_orders.sql`
→ `orders_monthly.csv`
→ forecasting models

`dw.v_sales_enriched`
→ `03_monthly_kpi.sql`
→ `monthly_kpi.csv`
→ revenue scenario analysis

---

## Notes

- Returned transactions are excluded using:
  WHERE is_return = false

- This ensures consistency with the data warehouse logic used across the project
