# Cohort Retention Analysis

**A structured cohort retention analysis designed to quantify early customer churn,
longitudinal retention behavior, and segment-level retention asymmetry
using warehouse-level transaction data.**

**Category:** Customer Analytics · Retention Strategy · Lifecycle Analysis

---

## Overview

This module analyzes **how long customers remain active after their first purchase**
by tracking retention behavior across cohorts and customer segments.

The analysis focuses on **early lifecycle churn**, which is the dominant driver
of long-term customer value and revenue sustainability.

All metrics are derived from validated dimensional models
and are intended to support **retention prioritization,
onboarding strategy design, and customer portfolio optimization**.

---

## Analysis Framework

Cohort retention is analyzed through the following lenses:

- Cohort definition based on first purchase month
- Retention curves across monthly lifecycle stages
- Early churn (M0 → M1) concentration analysis
- Segment-level retention asymmetry
- Sanity checks on customer base consistency

This framework answers questions such as:
- How quickly do new customers churn?
- Which cohorts retain longer over time?
- How concentrated is churn in the first month?
- How does retention differ across customer segments?

Each step progresses from **baseline → behavior → segmentation → validation**.

---

## 10. Cohort Definition

### Purpose
Define customer cohorts based on first purchase timing
to enable consistent longitudinal retention analysis.

### Artifacts
- `10_cohort_first_purchase.sql`

### Evidence
![Cohort First Purchase Month](./result/10_cohort_first_purchase_month.png)

---

## 20. Cohort Retention Matrix

### Purpose
Measure how customer cohorts retain over time
and identify structural drop-off patterns.

### Key Metrics
- Active customers by cohort and lifecycle month
- Retention rate by cohort index (M0, M1, M2, ...)

### Artifacts
- `20_cohort_retention_matrix.sql`

### Evidence
![Cohort Retention Matrix](./result/20_cohort_retention_matrix.png)

---

## 25. Early Retention Focus (M1)

### Purpose
Isolate first-month retention behavior
to quantify early lifecycle engagement quality.

### Key Metrics
- M1 retention rate
- One-month post-acquisition survival rate

### Artifacts
- `25_cohort_m1_retention.sql`

### Evidence
![Cohort M1 Retention](./result/25_cohort_m1_retention_churn.png)

---

## 30. Early Churn Summary

### Purpose
Quantify how many new customers fail to return
after their first purchase.

### Key Metrics
- M0 customer count
- M1 retained customers
- Early churn rate (1 − M1 retention)

### Artifacts
- `30_cohort_early_churn_summary.sql`

### Evidence
![Early Churn Summary](./result/30_cohort_early_churn_summary.png)

---

## 40. Segment-Level Cohort Base

### Purpose
Understand the composition of each cohort
by customer segment at acquisition.

### Key Metrics
- Cohort size by segment
- Segment distribution across cohorts

### Artifacts
- `40_segment_cohort_customer_base.sql`

### Evidence
![Segment Cohort Customer Base](./result/40_segment_cohort_customer_base.png)

---

## 50. Segment × Cohort Retention Matrix

### Purpose
Compare retention behavior across customer segments
to identify asymmetric lifecycle value patterns.

### Key Metrics
- Segment-level retention curves
- Retention gap between high- and low-value segments

### Artifacts
- `50_segment_cohort_retention_matrix.sql`

### Evidence
![Segment Cohort Retention Matrix](./result/50_segment_cohort_retention_matrix.png)

---

## 60. Segment Early Retention Summary

### Purpose
Highlight early churn concentration by segment
to inform retention investment prioritization.

### Key Metrics
- M1 retention rate by segment
- Early churn severity across segments

### Artifacts
- `60_segment_cohort_early_retention_summary.sql`

### Evidence
![Segment Early Retention Summary](./result/60_segment_cohort_early_retention_summary.png)

---

## Key Insights

- Customer churn is highly concentrated in the first month after acquisition.
- Only **15–36% of new customers** return within one month across cohorts.
- Retention curves remain structurally low after early drop-off,
  indicating limited natural recovery.
- High-value and VIP segments retain **3–5× longer** than low-value segments,
  while low-value customers churn almost immediately.

---

## Why Cohort Retention Analysis Matters

This analysis supports:

- Early lifecycle intervention strategy design
- Retention budget prioritization
- Identification of high-potential customer segments
- Downstream LTV and revenue forecasting accuracy

> Acquisition drives growth —  
> but **retention determines sustainability**.

---

## Dependencies

This module depends on:

- [Data Foundation](../../data_foundation/README.md)
- [Data Modeling](../../data_modeling/README.md)

All inputs are validated prior to analysis.

---

## Execution Order

1. Define customer cohorts
2. Compute cohort retention curves
3. Quantify early churn concentration
4. Segment customers by value
5. Compare segment-level retention behavior
6. Validate customer base consistency

---

## Next Steps

- Link early retention to cohort-level LTV outcomes
- Integrate acquisition cost for full unit economics
- Feed retention metrics into BI dashboards and forecasting models
