# Data Modeling

**A documented implementation of the dimensional data model and analytics marts,
transforming clean retail data into structured, analytics-ready datasets.**

## Overview

The Data Modeling layer transforms validated data from the Data Foundation
into structured fact and dimension tables, followed by analytics-ready KPI marts.

This layer focuses on **business logic, dimensional modeling, and analytical usability**,
bridging clean data and business insights.

---

## Architecture Scope

This layer consists of two core sublayers:

- **Core Warehouse (`30_dw`)** — Fact and dimension tables with defined grain and relationships  
- **Analytics Marts (`40_marts`)** — KPI-focused tables for reporting and analysis

20_staging
↓
30_dw (facts & dimensions)
↓
40_marts (analytics marts)

---

## 1. Core Warehouse Layer (30_dw)

### Purpose
- Model business processes using fact and dimension tables
- Define consistent join keys and table grain
- Establish a reliable analytical backbone

### Dimension Tables
- **dim_date** — Calendar and time attributes
- **dim_customer** — Customer identity and location
- **dim_product** — Product catalog and descriptions

### Fact Table
- **fact_sales** — Transaction-level sales facts

---

### Evidence – Core Warehouse Execution Results

The following outputs demonstrate the successful creation
of dimension and fact tables, along with enforced relationships.

**Date dimension creation**

![Create dim_date](./30_create_dim_date.png)


**Customer dimension creation**

![Create dim_customer](./31_create_dim_customer.png)


**Product dimension creation**

![Create dim_product](./32_create_dim_product.png)


**Fact table creation**

![Create fact_sales](./33_create_fact_sales.png)


**Foreign key constraints applied**

![Add FK Constraints](./34_add_fk_constraints.png)

---

## 2. Analytics Marts Layer (40_marts)

### Purpose
- Provide business-ready datasets for KPI reporting
- Centralize metric definitions
- Simplify analytical queries for end users

### Key KPIs Implemented
- Monthly revenue trends
- Top-selling products
- Revenue by country
- Return rate
- Repeat purchase behavior

---

### Evidence – Analytics Marts Results

The following outputs show KPI queries built on top of the dimensional model.

**Monthly revenue KPI**

![Monthly Revenue KPI](./40_kpi_monthly_revenue.png)


**Top products KPI**

![Top Products KPI](./41_kpi_top_products.png)


**Revenue by country KPI**

![Country Revenue KPI](./42_kpi_country_revenue.png)


**Return rate KPI**

![Return Rate KPI](./43_kpi_return_rate.png)


**Repeat purchase KPI**

![Repeat Purchase KPI](./44_kpi_repeat_purchase.png)

---

## Modeling Principles

- **Dimensional modeling (star schema)** for analytical efficiency
- **Single source of truth** in the core warehouse
- **Clear separation of concerns** between modeling and data preparation
- **Reusability** of dimensions across multiple KPIs

---

## Why Data Modeling Matters

A well-designed data model:

- Ensures consistent KPI definitions
- Simplifies analytical queries
- Improves performance and scalability
- Enables trustworthy business insights

> Analytics is only as reliable as the model beneath it.

---

## Upstream Dependency

This layer depends exclusively on the Data Foundation:

- `data_foundation/10_raw`
- `data_foundation/20_staging`

Only validated and standardized data is used for modeling.

---

## Next Steps

- Add ERD visualization for fact–dimension relationships
- Expand KPI coverage with additional marts
- Validate metric consistency across analytics marts
