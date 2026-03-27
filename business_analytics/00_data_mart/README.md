# Data Mart

## Overview
This module creates the analytical base dataset used across all business analytics modules.

## Purpose
To provide a standardized, KPI-ready data layer that simplifies downstream analysis.

## Key Logic
- Aggregates transactional data into business-friendly structures
- Prepares KPI-level datasets (Revenue, Orders, AOV)
- Ensures consistency across all analytical modules

## How to Use
Run SQL scripts in:

- business_analytics/00_data_mart/

This step must be completed before running downstream analytical modules.

## Why It Matters
This layer ensures that all analytical modules operate on a consistent and validated data foundation,
preventing discrepancies across analyses.

## 🔗 Data Flow

The datasets in this module are structured to support different levels of analysis:

- `mart_sales_enriched.csv` → Base dataset (transaction-level)
- `mart_customer_segments.csv` → Customer-level aggregation
- `mart_kpi_monthly.csv` → Monthly KPI aggregation
- `mart_kpi_monthly_mom_qoq.csv` → KPI trend and growth metrics

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

---

## 🔗 Downstream Usage

These datasets are used across multiple analytical modules, including:

- Revenue Driver Analysis
- Customer Segmentation
- Product Mix Analysis
- Cohort Retention
- Operational Risk Analysis
- Metric Layer
