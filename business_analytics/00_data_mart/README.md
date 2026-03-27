# Data Mart

## Overview
This module creates the analytical base dataset used across all business analytics modules.

## Purpose
To provide a standardized, KPI-ready data layer that simplifies downstream analysis.

## Key Logic
- Aggregates transactional data into business-friendly structures
- Prepares KPI-level datasets (Revenue, Orders, AOV)
- Ensures consistency across all analytical modules

## Outputs
- KPI-ready aggregated tables
- Standardized analytical datasets

## How to Use
Run SQL scripts in:

- 00_data_mart/

## Why It Matters
This layer ensures that all analytical modules operate on a consistent and validated data foundation,
preventing discrepancies across analyses.

## 📊 Data Outputs

This module produces standardized analytical datasets used across downstream analysis and dashboards.

### 1. mart_sales_enriched.csv
- Description: Transaction-level dataset enriched with customer, product, and derived metrics
- Key Fields:
  - order_id
  - customer_id
  - product_id
  - revenue
  - order_date
- Usage:
  - Base dataset for all analytical modules
  - Input for revenue, product, and retention analysis

---

### 2. mart_customer_segments.csv
- Description: Customer-level segmentation dataset based on behavioral metrics
- Key Fields:
  - customer_id
  - segment
  - total_revenue
  - order_count
- Usage:
  - Customer segmentation analysis
  - LTV and retention modeling

---

### 3. mart_kpi_monthly.csv
- Description: Monthly aggregated KPI dataset
- Key Fields:
  - month
  - total_revenue
  - total_orders
  - avg_order_value
- Usage:
  - KPI trend analysis
  - Dashboard reporting

---

### 4. mart_kpi_monthly_mom_qoq.csv
- Description: KPI dataset with MoM and QoQ growth metrics
- Key Fields:
  - month
  - revenue_mom
  - revenue_qoq
  - orders_mom
- Usage:
  - Performance trend analysis
  - Executive reporting
