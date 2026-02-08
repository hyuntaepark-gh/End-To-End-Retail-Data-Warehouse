# Business Analytics

**Decision-oriented analytical modules built on top of a validated
enterprise data warehouse to explain business performance and support action.**

---

## Overview

The Business Analytics layer translates curated warehouse data
into **explainable business insights**.

Unlike upstream layers that focus on data correctness and structure,
this layer focuses on:

- *Why* metrics change
- *Which* drivers matter most
- *How* insights can inform decisions

All analyses are built on top of validated models in the `dw` and `marts`
schemas and assume that data quality has already been enforced.

---

## Architecture Scope

This layer sits at the top of the analytics stack:

raw / staging → dw → marts
↑
business analytics

Each sub-module represents a **self-contained analytical question**
with its own SQL logic, outputs, and validation steps.

---

## Analysis Modules

### 01. Revenue Driver Analysis

**Question:**  
What drives revenue growth and decline?

**Focus:**
- Revenue decomposition (Orders × AOV)
- Volume vs. price effects
- Country-level revenue drivers
- Customer mix and growth attribution
- Returns impact and sanity checks

📂 `01_revenue_driver_analysis/`

---

### 02. Customer Segmentation

**Question:**  
How can customers be grouped based on behavior and value?

**Focus:**
- Purchase frequency and recency
- Revenue contribution by segment
- Behavioral patterns across customer cohorts

📂 `02_customer_segmentation/`

---

### 03. Product Mix Analysis

**Question:**  
Which products drive performance and how does the mix change over time?

**Focus:**
- Revenue concentration
- Top-product dependency
- Product contribution trends

📂 `03_product_mix_analysis/`

---

### 04. Returns Analysis

**Question:**  
How do returns affect revenue, KPIs, and operational performance?

**Focus:**
- Return rates
- Revenue loss due to returns
- Product and customer-level return behavior

📂 `04_returns_analysis/`

---

### 05. Customer Lifetime Value (LTV) Analysis

**Question:**  
Which customers create long-term value?

**Focus:**
- Revenue longevity
- Repeat purchase behavior
- Early-stage value indicators

📂 `05_ltv_analysis/`

---

## Design Principles

All analytics in this layer follow these principles:

- **Decision-first**: Every analysis answers a concrete business question
- **Explainability**: Metrics are decomposed into understandable drivers
- **Reproducibility**: All logic is implemented in SQL with deterministic outputs
- **Validation-aware**: Sanity checks are included before interpretation

---

## Dependencies

This layer depends on the following upstream components:

- [Data Foundation](../data_foundation/README.md)  
- [Data Modeling](../data_modeling/README.md)  
- [Data Operations](../data_operations/README.md)

All inputs are assumed to be standardized, validated, and reconciled.

---

## Why Business Analytics Matters

Well-modeled data alone does not create value.

This layer bridges the gap between:
- **Correct data** and **correct decisions**
- **Metrics** and **meaning**
- **Reporting** and **strategy**

> Analytics is not about numbers — it is about understanding drivers.

---

## Next Steps

- Extend analyses with margin and profitability views
- Integrate results into BI dashboards
- Apply the same framework to forecasting and scenario modeling
