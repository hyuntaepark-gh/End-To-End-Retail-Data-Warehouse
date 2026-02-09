# Business Analytics

**Decision-oriented analytical modules built on top of a validated
enterprise data warehouse to explain business performance and support action.**

---

## Overview

The Business Analytics layer translates curated warehouse data
into **explainable, decision-ready business insights**.

Unlike upstream layers that focus on data correctness and structure,
this layer is explicitly designed to answer:

- *Why* key metrics change  
- *Which* drivers matter most  
- *How* insights should inform business decisions  

All analyses are built on validated models in the `dw` and `marts`
schemas and assume that data quality, reconciliation, and consistency
have already been enforced upstream.

---

## Architecture Scope

This layer operates at the top of the analytics stack,
assuming all ingestion, modeling, and validation steps
have already been completed upstream.

raw / staging → dw → marts
↑
business analytics

Each sub-module represents a **self-contained analytical question**
implemented with deterministic SQL logic, documented outputs,
and validation checks prior to interpretation.

---

## Analysis Modules

The modules below progress from descriptive performance analysis
to diagnostic driver analysis, risk identification,
and decision-enabling metric abstraction.

---

### 01. Revenue Driver Analysis
**Business Question:**  
What drives revenue growth and decline?

**Focus:**
- Revenue decomposition (Orders × AOV)
- Volume vs. price effects
- Country-level revenue drivers
- Customer mix and growth attribution
- Returns impact and sanity validation

📂 `01_revenue_driver_analysis/`

---

### 02. Customer Segmentation
**Business Question:**  
How can customers be grouped based on behavior and value?

**Focus:**
- Purchase frequency and recency
- Revenue contribution by segment
- Behavioral differences across customer cohorts

📂 `02_customer_segmentation/`

---

### 03. Product Mix Analysis
**Business Question:**  
Which products drive performance, and how does the mix evolve over time?

**Focus:**
- Revenue concentration
- Dependency on top products
- Product contribution trends

📂 `03_product_mix_analysis/`

---

### 04. Returns Analysis
**Business Question:**  
How do returns affect revenue, KPIs, and operational performance?

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
- Revenue longevity
- Repeat purchase behavior
- Early-stage indicators of lifetime value

📂 `05_ltv_analysis/`

---

### 06. Revenue Driver × Segment Analysis
**Business Question:**  
Do revenue drivers differ across customer segments?

**Focus:**
- Orders vs. AOV contribution by segment
- Segment-level revenue sensitivity
- Structural differences in growth drivers

📂 `06_revenue_driver_x_segment/`

---

### 07. Price Sensitivity (Discount Proxy) Analysis
**Business Question:**  
How sensitive is demand to price-related signals?

**Focus:**
- Discount proxy identification
- Order response to effective price changes
- Revenue trade-offs from price sensitivity

📂 `07_price_sensitivity_discount_proxy_analysis/`

---

### 08. Cohort Retention Analysis
**Business Question:**  
How does customer retention evolve across acquisition cohorts?

**Focus:**
- Cohort-based retention curves
- Early churn vs. long-term retention
- Behavioral differences across cohorts

📂 `08_cohort_retention/`

---

### 09. Operational Risk Analysis
**Business Question:**  
Which products pose the highest operational and revenue risk?

**Focus:**
- Returns × revenue impact
- High-volume, high-return risk identification
- Operational prioritization signals

📂 `09_operational_risk_analysis/`

---

### 10. Data Quality & Assumption Disclosure
**Business Question:**  
What data limitations affect interpretation and decision-making?

**Focus:**
- Missing customer identifiers
- Revenue impact of returns
- Extreme value detection (AOV outliers)

📂 `10_data_quality_assumptions/`

---

### 11. Metric Layer (KPI Mart)
**Business Question:**  
How can core business metrics be standardized and reused?

**Focus:**
- Monthly KPI definitions (Revenue, Orders, Customers, AOV)
- Metric consistency across analyses
- BI-ready metric abstraction layer

📂 `11_metric_layer/`

---

## Design Principles

All analytics in this layer adhere to the following principles:

- **Decision-first**  
  Every analysis is framed around a concrete business question.

- **Explainability**  
  Metrics are decomposed into interpretable drivers rather than reported in isolation.

- **Reproducibility**  
  All logic is implemented in SQL with deterministic, auditable outputs.

- **Validation-aware**  
  Sanity checks and reconciliation are performed before interpretation.

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

## Business Recommendation Layer

This section represents the **final decision layer** of the analytics stack.

While the analytical modules above focus on explaining *why* performance changes,
this layer explicitly addresses *what actions should be taken next*.

Recommendations are intentionally free of SQL,
intermediate metrics, and implementation detail.
They are written to be **executive-readable, action-oriented,
and directly traceable to validated analytical findings**.

---

## Recommendation Traceability Map

The map below illustrates how individual analytical modules
contribute to the final business recommendations.

Each **Derived Recommendation** represents a localized, analysis-level decision insight,
which collectively supports the executive-level conclusions
presented in the Business Recommendation Layer.

```

[01. Revenue Driver Analysis]
        └─ Derived Recommendation
              ↓
[BR-1] Prioritize demand stimulation over pricing changes
              ↓
--------------------------------------------------

[02. Customer Segmentation]        [05. LTV Analysis]
        └─ Derived Recommendation          └─ Derived Recommendation
                     ↓                     ↓
              [BR-2] Invest in retention for high-value customer segments
                     ↓
--------------------------------------------------

[04. Returns Analysis]             [09. Operational Risk Analysis]
        └─ Derived Recommendation          └─ Derived Recommendation
                     ↓                     ↓
              [BR-3] Address returns through targeted operational reviews
                     ↓
--------------------------------------------------

[08. Cohort Retention Analysis]
        └─ Derived Recommendation
                     ↓
              [BR-4] Re-evaluate recent acquisition quality

```

---

### Key Business Recommendations

1. **Prioritize demand stimulation over pricing changes.**  
   *(Derived from Revenue Driver Analysis)*  
   Revenue volatility is primarily driven by order volume fluctuations rather than AOV,
   suggesting that acquisition and activation initiatives should be prioritized
   over price optimization efforts.

2. **Invest in retention for high-value customer segments.**  
   *(Derived from Customer Segmentation & LTV Analysis)*  
   A small number of customer segments contribute disproportionately to total revenue,
   indicating that targeted retention strategies are likely to generate higher ROI
   than broad acquisition campaigns.

3. **Address returns through targeted operational reviews.**  
   *(Derived from Returns & Operational Risk Analysis)*  
   Returns are concentrated among a limited set of products,
   pointing to potential quality, fulfillment, or expectation-setting issues
   that should be addressed selectively rather than through system-wide changes.

4. **Re-evaluate recent acquisition quality.**  
   *(Derived from Cohort Retention Analysis)*  
   Newer customer cohorts exhibit faster churn,
   suggesting that recent acquisition sources may be attracting lower-intent customers
   and should be re-assessed with a focus on long-term value rather than short-term volume.

---

## Next Steps

- Extend analyses with margin and profitability views  
- Integrate analytical outputs into BI dashboards  
- Apply the same framework to forecasting and scenario modeling  
