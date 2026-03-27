# Business Analytics

Decision-oriented analytical modules built on top of a validated
enterprise data warehouse to explain business performance
and support actionable decision-making.

---

## Overview

The Business Analytics layer translates curated warehouse data
into explainable, decision-ready business insights.

Unlike upstream layers that focus on data correctness,
modeling, and metric standardization,
this layer is explicitly designed to answer:

- Why key metrics change
- Which drivers matter most
- How insights should inform business decisions

All analyses are built on validated models
in the dw and marts schemas
and assume that data quality, reconciliation,
and consistency have already been enforced upstream.

---

## Architecture Scope

This layer operates at the top of the analytics stack,
assuming all ingestion, modeling,
and validation steps have already been completed.

raw / staging → dw → marts  
↑  
business analytics

Each sub-module represents a self-contained analytical question,
implemented with deterministic SQL logic,
documented outputs, and validation checks
prior to interpretation.

---

## Analysis Modules

The modules below progress from descriptive performance analysis
to diagnostic driver analysis,
risk identification,
and decision-enabling metric abstraction.

---

### 00. Data Mart

**Business Question:**  
What is the standardized analytical base dataset?

**Focus:**
- KPI-ready aggregated tables
- Business-friendly data structures
- Consistent analytical foundation

📂 `00_data_mart/`

---

### 00. Dashboard

**Business Question:**  
How can key metrics be visualized for decision-makers?

**Focus:**
- KPI visualization
- Executive-level dashboards
- Metric monitoring and reporting

📂 `00_dashboard/`

---

### 01. Revenue Driver Analysis

**Business Question:**  
What drives revenue growth and decline?

**Focus:**
- Revenue decomposition (Orders × AOV)
- Volume versus price effects
- Geographic revenue drivers
- Customer mix attribution
- Returns impact and sanity validation

📂 `01_revenue_driver_analysis/`

---

### 02. Customer Segmentation

**Business Question:**  
How can customers be grouped based on behavior and value?

**Focus:**
- Recency, frequency, and monetary behavior
- Revenue contribution by segment
- Behavioral separation across customer groups

📂 `02_customer_segmentation/`

---

### 03. Product Mix Analysis

**Business Question:**  
Which products drive performance,
and how does the portfolio evolve over time?

**Focus:**
- Revenue concentration
- Dependency on top products
- Product contribution and stability

📂 `03_product_mix_analysis/`

---

### 04. Returns Analysis

**Business Question:**  
How do returns affect revenue,
KPIs, and operational performance?

**Focus:**
- Return rates and patterns
- Revenue loss due to returns
- Product- and customer-level return behavior

📂 `04_returns_analysis/`

---

### 05. Customer Lifetime Value (LTV) Analysis

**Business Question:**  
Which customers create long-term value?

**Focus:**
- Revenue longevity by cohort
- Repeat purchase behavior
- Early indicators of lifetime value

📂 `05_ltv_analysis/`

---

### 06. Revenue Driver × Segment Analysis

**Business Question:**  
Do revenue drivers differ across customer segments?

**Focus:**
- Orders versus AOV contribution by segment
- Segment-level revenue sensitivity
- Structural differences in growth drivers

📂 `06_revenue_driver_x_segment/`

---

### 07. Price Sensitivity and Discount Proxy Analysis

**Business Question:**  
How sensitive is demand to price-related signals?

**Focus:**
- Discount proxy identification
- Order response to effective price changes
- Revenue and volatility trade-offs

📂 `07_price_sensitivity_discount_proxy_analysis/`

---

### 08. Cohort Retention Analysis

**Business Question:**  
How does customer retention evolve
across acquisition cohorts?

**Focus:**
- Cohort-based retention curves
- Early churn versus long-term retention
- Behavioral differences across cohorts

📂 `08_cohort_retention/`

---

### 09. Operational Risk Analysis

**Business Question:**  
Which products pose the highest operational
and revenue risk?

**Focus:**
- Returns multiplied by revenue impact
- High-volume, high-return risk identification
- Operational prioritization signals

📂 `09_operational_risk_analysis/`

---

### 10. Data Quality and Assumption Disclosure

**Business Question:**  
What data limitations affect interpretation
and decision reliability?

**Focus:**
- Identifier completeness
- Revenue distortion from returns
- Extreme value sensitivity and KPI interpretation

📂 `10_data_quality_assumptions/`

---

### 11. Metric Layer (KPI Mart)

**Business Question:**  
How can core business metrics
be standardized and reused?

**Focus:**
- Monthly KPI definitions
- Metric consistency across analyses
- BI-ready metric abstraction layer

📂 `11_metric_layer/`

---

## 📊 Outputs

This layer produces decision-oriented analytical outputs including:

- KPI decomposition results (Revenue, Orders, AOV)
- Customer segmentation insights
- Product performance analysis
- Return impact evaluation
- Cohort retention patterns
- Operational risk signals
- Standardized KPI metric layer

All outputs are traceable to validated warehouse data
and designed for direct business interpretation.

---

## Design Principles

All analytics in this layer adhere to the following principles:

- Decision-first  
- Explainability  
- Reproducibility  
- Validation-aware  

---

## ▶️ How to Run

Execute analytical SQL modules in sequence:

- business_analytics/00_data_mart
- business_analytics/01_revenue_driver_analysis
- business_analytics/02_customer_segmentation
- business_analytics/03_product_mix_analysis
- business_analytics/04_returns_analysis
- business_analytics/05_ltv_analysis
- business_analytics/06_revenue_driver_x_segment
- business_analytics/07_price_sensitivity_discount_proxy_analysis
- business_analytics/08_cohort_retention
- business_analytics/09_operational_risk_analysis
- business_analytics/10_data_quality_assumptions
- business_analytics/11_metric_layer

Each module can be run independently depending on the business question.

---

## Dependencies

This layer depends on the following upstream components:

- ../data_foundation/README.md
- ../data_modeling/README.md
- ../data_operations/README.md

---

## Why Business Analytics Matters

Well-modeled data alone does not create value.

This layer bridges the gap between:

- Correct data and correct decisions
- Metrics and meaning
- Reporting and strategy

Analytics is not about numbers.
It is about understanding drivers.

---

## Business Recommendation Layer

This section represents the final decision layer
of the analytics stack.

While individual analytical modules
focus on explaining why performance changes,
this layer explicitly addresses
what actions should be taken next.

---

## Recommendation Traceability Map

Each derived recommendation originates
from a specific analytical module and rolls up into executive-level guidance.

```
[01. Revenue Driver Analysis]
        └─ Derived Recommendation
              ↓
[BR-1] Prioritize demand stimulation over pricing changes
--------------------------------------------------

[02. Customer Segmentation]        [05. LTV Analysis]
        └─ Derived Recommendation          └─ Derived Recommendation
                     ↓                     ↓
              [BR-2] Invest in retention for high-value customer segments
--------------------------------------------------

[04. Returns Analysis]             [09. Operational Risk Analysis]
        └─ Derived Recommendation          └─ Derived Recommendation
                     ↓                     ↓
              [BR-3] Address returns through targeted operational reviews
--------------------------------------------------

[08. Cohort Retention Analysis]
        └─ Derived Recommendation
                     ↓
              [BR-4] Re-evaluate recent acquisition quality
```
  
---

## Key Business Recommendations

1. Prioritize demand stimulation over pricing changes.  
   Revenue volatility is primarily driven by order volume
   rather than average order value,
   suggesting acquisition and activation initiatives
   should be prioritized over pricing adjustments.

2. Invest in retention for high-value customer segments.  
   A small number of customer segments
   contribute disproportionately to total revenue,
   indicating higher ROI from targeted retention
   than from broad acquisition efforts.

3. Address returns through targeted operational reviews.  
   Returns are concentrated among a limited set of products,
   pointing to quality, fulfillment,
   or expectation-setting issues
   that should be addressed selectively.

4. Re-evaluate recent acquisition quality.  
   Newer customer cohorts exhibit faster churn,
   suggesting recent acquisition sources
   may be attracting lower-intent customers
   and should be assessed on long-term value.

---

## Next Steps

- Extend analyses with margin and profitability views
- Integrate analytical outputs into BI dashboards
- Apply the same framework to forecasting
