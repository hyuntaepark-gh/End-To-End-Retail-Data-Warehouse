# Data Quality and Analytical Assumptions

Validating data integrity and disclosing analytical assumptions
to ensure trustworthy operational risk insights.

Category: Data Quality · Analytical Assumptions · KPI Integrity · Decision Reliability

---

## Overview

This module explicitly validates data quality
and documents analytical assumptions
underpinning the operational risk analysis.

Rather than assuming data correctness,
this step verifies whether the dataset
supports customer-level analysis,
revenue-based KPIs,
and return-risk interpretation without distortion.

The objective is not to clean the data,
but to define what the data can and cannot reliably support,
ensuring that downstream insights are interpreted
within known and disclosed constraints.

All checks are executed directly on validated warehouse views
and are designed to strengthen decision confidence
rather than model performance.

---

## Validation Framework

Data quality and assumptions are evaluated across the following dimensions:

- Customer identifier completeness
- Return transaction representation consistency
- Revenue distortion from returns
- Order value distribution and tail risk
- Metric sensitivity to extreme values
- Alignment between frequency-based and value-based risk

Each check either validates
or explicitly constrains
the interpretation of downstream analyses.

---

## 10. Customer Identifier Completeness

### Interpretation

All transactions contain valid customer identifiers.
Customer-level analyses can be performed
without identifier-related sampling bias.

### Assumption

Customer-level KPIs are computed
on the full transaction population.

Artifacts:
- 10_missing_customer_id_ratio.sql

---

## 20. Return Transaction Identification Consistency

### Interpretation

Return-related revenue identified via invoice flags
exactly matches revenue identified via negative transaction values.

### Assumption

Return logic is robust and unambiguous
and is consistently applied across all analyses.

Artifacts:
- 20_return_revenue_ratio_by_invoice_flag.sql
- 30_return_revenue_ratio_by_negative_amount.sql

---

## 40. Order Value Distribution and Extreme Values

### Interpretation

Order revenue follows a heavy-tailed distribution.
A small fraction of orders
are substantially larger than the median.

### Assumption

Mean-based metrics such as AOV
must be interpreted alongside
distribution-aware context.

Artifacts:
- 40_extreme_order_value_percentiles.sql

---

## 50. Revenue Concentration in Extreme Orders

### Interpretation

A small fraction of orders
accounts for a disproportionate share of revenue.

### Assumption

Revenue KPIs are sensitive to extreme values
and should not be interpreted
without understanding tail concentration.

Artifacts:
- 50_top1pct_revenue_concentration.sql

---

## 60. Gross vs Net AOV Sensitivity

### Interpretation

Excluding return transactions
materially alters AOV estimates.

### Assumption

All revenue and AOV metrics
are reported with explicit clarification
regarding return inclusion.

Artifacts:
- 60_gross_vs_net_aov.sql

---

## 70. Extreme Value Capping Simulation

### Interpretation

Capping extreme values
produces materially different AOV estimates,
demonstrating average sensitivity to outliers.

### Assumption

While uncapped metrics are reported,
decision-making must account
for tail sensitivity.

Artifacts:
- 70_capped_aov_simulation.sql

---

## 80. Returns and Extreme Orders

### Interpretation

Extreme high-value orders
exhibit minimal return activity.

### Assumption

Operational return risk
is not driven by premium transactions.

Artifacts:
- 80_returns_vs_extreme_order_analysis.sql

---

## 90. Return Risk by Order Value Decile

### Interpretation

Return frequency and return-related revenue loss
are concentrated in mid-to-low order value segments.

### Assumption

Operational risk mitigation should focus
on high-volume, non-premium transactions.

Artifacts:
- 90_return_rate_by_order_value_decile.sql
- 95_return_revenue_share_by_order_value_decile.sql
- 96_v_return_risk_by_order_value_decile.sql

---

## Data Quality and Assumption Summary

- Customer-level analyses are not biased by missing identifiers.
- Return transactions are consistently and reliably identified.
- Revenue and AOV metrics are sensitive to return behavior.
- Order value distributions are heavy-tailed.
- Extreme orders distort averages but do not drive return risk.
- Operational return risk is volume-driven rather than premium-driven.

---

## Why Data Quality and Assumptions Matter

Without explicit validation,
operational risk insights
can be misinterpreted or misprioritized.

This module ensures that:

- KPIs reflect real operational signals
- Risk concentration is not an artifact of data distortion
- Decision-makers understand metric limitations
- Downstream recommendations are defensible

Good analysis does not start with results.
It starts with knowing what the data can support.

---

## Derived Recommendation

Because revenue and return metrics are highly sensitive
to distributional skew and return treatment,
operational risk insights should be interpreted
with explicit awareness of tail effects and KPI definitions.

Risk prioritization decisions are most reliable
when frequency-based and value-based signals
are considered jointly rather than in isolation.

---

## Dependencies

This module depends on:

- ../../data_foundation/README.md
- ../../data_modeling/README.md
- ../09_operational_risk_analysis/README.md

All assumptions are validated
prior to downstream analysis.

---

## Summary

By explicitly validating data quality
and disclosing analytical assumptions,
this project ensures that
operational risk insights
are explainable, defensible, and trustworthy.

Rather than obscuring limitations,
this module makes them explicit,
strengthening confidence
in every recommendation that follows.

---

## Next Steps

- Integrate assumption-aware KPIs into BI dashboards
- Embed validated risk metrics into forecasting models
- Automate monitoring for assumption drift
- Extend validation logic to new datasets and domains
