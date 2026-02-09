# Metric Layer & KPI Mart Design

**A production-style metric layer designed to define,
standardize, and expose business KPIs for BI consumption
using SQL-based marts and semantic definitions.**

**Category:** BI Analytics · Metric Engineering · Revenue & Operations

> This metric layer acts as the **single source of truth (SSOT)**
> for executive dashboards, operational reporting, and downstream analytics.

---

## Overview

This metric layer defines the **canonical business metrics**
used across dashboards, reporting, and downstream analyses.

All KPIs are computed at the **database layer** using SQL views,
ensuring consistency, reusability, and governance across BI tools
such as Power BI and Tableau.

Rather than embedding logic inside visualization tools,
this layer centralizes metric definitions and exposes
clean, consumption-ready marts.

---

## Why This Layer Matters

- Eliminate metric discrepancies across dashboards
- Ensure consistent KPI definitions across teams
- Reduce BI-layer calculation complexity
- Enable scalable analytics and experimentation
- Support executive, operational, and analytical use cases

> Metrics are organizational contracts —  
> **they must be defined once and trusted everywhere.**

---

## Metric Layer Architecture

- **Base Fact View**  
  Canonical sales representation with standardized revenue, return flags,
  and date attributes

- **Core KPI Marts**  
  Monthly revenue, order, and customer metrics used by executives

- **Derived Trend Marts**  
  Precomputed MoM and QoQ deltas to ensure consistent trend interpretation

- **Segment & Operational Marts**  
  Customer segmentation and product-level return risk metrics

- **Validation Queries**  
  Explicit sanity checks to ensure data quality and metric correctness

This layer sits **between the data warehouse fact tables
and all BI or analytical consumption layers**, ensuring
consistent KPI semantics across the organization.

---

## Who Uses This Metric Layer

- **Executives**: KPI cards, revenue trends, MoM/QoQ performance tracking  
- **BI Analysts**: Dashboard development without redefining metrics  
- **Operations Teams**: Return risk and product-level monitoring  
- **Data Scientists**: Reliable feature inputs for forecasting and modeling  

---

## Metric Marts

---

## 10. Base Sales View

### Purpose
Provide a standardized, analytics-ready sales fact view
that serves as the foundation for all downstream KPI marts.

### Artifacts
- `10_v_sales_enriched.sql`

### Evidence
![Base Sales View](./result/10_v_sales_enriched.png)  
*Canonical sales view with standardized revenue, return flags, and date attributes.*

---

## 20. Core Monthly KPI Mart

### Purpose
Expose executive-level monthly KPIs
used across revenue and performance dashboards.

### Key Metrics
- Orders
- Customers
- Revenue
- Average Order Value (AOV)

### Artifacts
- `20_mart_kpi_monthly.sql`

### Evidence
![Monthly KPI Mart](./result/20_mart_kpi_monthly.png)  
*Monthly revenue, order, and customer KPIs ready for BI consumption.*

---

## 21. Monthly KPI by Country

### Purpose
Enable geographic performance analysis
by extending core KPIs with country-level segmentation.

### Artifacts
- `21_mart_kpi_monthly_country.sql`

### Evidence
![Country KPI Mart](./result/21_mart_kpi_monthly_country.png)  
*Monthly KPIs broken down by country to support regional analysis.*

---

## 22. Monthly KPI MoM Trends

### Purpose
Precompute month-over-month KPI changes
to support executive trend analysis without BI-side calculations.

### Artifacts
- `22_mart_kpi_monthly_mom.sql`

### Evidence
![KPI MoM](./result/22_mart_kpi_monthly_mom.png)  
*Month-over-month KPI deltas used in executive dashboards.*

---

## 30. Returns & Revenue Impact Mart

### Purpose
Quantify the operational and financial impact of returns
at the monthly level.

### Artifacts
- `30_mart_return_risk_monthly.sql`

### Evidence
![Monthly Returns Risk](./result/30_mart_return_risk_monthly.png)  
*Shows return volume, revenue impact, and return rate over time.*

---

## 40. MoM / QoQ Trend KPI Mart

### Purpose
Provide both MoM and QoQ trend metrics
for higher-level performance evaluation.

### Artifacts
- `40_mart_kpi_monthly_mom_qoq.sql`

### Evidence
![KPI MoM QoQ](./result/40_mart_kpi_monthly_mom_qoq.png)  
*Precomputed MoM and QoQ deltas ensure consistent trend interpretation.*

---

## 50. New vs Returning Customer Mart

### Purpose
Decompose customer growth into acquisition and retention
by classifying customers based on their first purchase month.

### Artifacts
- `50_mart_customer_new_vs_returning_monthly.sql`

### Evidence
![New vs Returning Customers](./result/50_mart_customer_new_vs_returning_monthly.png)  
*Separates customer growth into new acquisition and repeat behavior.*

---

## 60. Product Return Risk Mart

### Purpose
Identify products with the highest operational and
financial risk due to return behavior.

### Artifacts
- `60_mart_product_return_risk.sql`

### Evidence
![Product Return Risk](./result/60_mart_product_return_risk.png)  
*Highlights products with high return rates and revenue loss.*

---

## Metric Dictionary

### 1) Global Conventions

- **Returns**: Transactions flagged with `is_return = true`
- **Net Metrics**: Exclude returns unless explicitly stated
- **Date Grain**: Monthly, derived from `date_key (YYYYMMDD)` → `year`, `month`

---

### 2) Core KPI Mart — `dw.mart_kpi_monthly`

| Metric | Definition |
|---|---|
| Orders | Distinct invoices excluding returns |
| Customers | Distinct customers excluding returns |
| Revenue | Sum of revenue (returns recorded as negative) |
| AOV | Revenue / Orders |

---

### 3) Returns Mart — `dw.mart_returns_monthly`

| Metric | Definition |
|---|---|
| Return Orders | Distinct return invoices |
| Return Revenue | Sum of return revenue (negative) |
| Return Rate | Return Orders / Total Orders |

---

### 4) Product Return Risk Mart — `dw.mart_product_return_risk`

| Metric | Definition |
|---|---|
| Net Orders | Orders excluding returns |
| Return Orders | Orders with returns |
| Return Rate | Return Orders / Total Orders |
| Return Loss | `ABS(return_revenue)` |

Metric definitions are enforced at the SQL layer
and are not recalculated in BI tools.

---

## Validation & Sanity Checks

### Purpose
Ensure metric accuracy and analytical consistency
before BI consumption.

### Artifacts
- `99_validation_metric_layer.sql`

### Evidence
![Validation Check 1](./result/99_validation_metric_layer1.png)  
![Validation Check 2](./result/99_validation_metric_layer2.png)  
![Validation Check 3](./result/99_validation_metric_layer3.png)  
![Validation Check 4](./result/99_validation_metric_layer4.png)  
![Validation Check 5](./result/99_validation_metric_layer5.png)  
![Validation Check 6](./result/99_validation_metric_layer6.png)  
![Validation Check 7](./result/99_validation_metric_layer7.png)  
![Validation Check 8](./result/99_validation_metric_layer8.png)  
![Validation Check 9](./result/99_validation_metric_layer9.png)

All validation checks passed, confirming that
the metric marts are internally consistent and
ready for BI and analytical consumption.

---

## Design Decisions

- KPIs are precomputed in SQL to avoid metric drift in BI tools
- Views are recreated (DROP + CREATE) when definitions change
- Validation queries are intentionally separated from metric definitions

---

## Usage

- BI tools connect directly to `dw.mart_*` views
- No KPI calculations are performed in the visualization layer
- All dashboards reference a single source of metric truth

---

## Execution Order

1. Create base sales view  
2. Build core KPI marts  
3. Derive trend, customer, and product marts  
4. Run validation queries  
5. Connect BI tools to finalized marts  
