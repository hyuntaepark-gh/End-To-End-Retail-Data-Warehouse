# Revenue Driver Analysis by Customer Segment

**A structured revenue driver decomposition designed to explain
monthly revenue fluctuations by customer segment,
separating volume, price, and mix effects using warehouse-level data.**

**Category:** Revenue Analytics · Segment Strategy · Performance Diagnostics

---

## Overview

This module analyzes **why revenue changes over time**
by decomposing revenue movements into interpretable drivers
and comparing how those drivers differ across customer segments.

Rather than focusing on aggregate revenue alone,
this analysis isolates **which segments drive growth or decline**
and whether changes are driven by **customer volume, pricing behavior,
or product mix shifts**.

All analyses are built on top of validated dimensional warehouse models
and are intended to support **segment-level growth strategy,
pricing decisions, and revenue risk assessment**.

---

## Analysis Framework

Revenue drivers are analyzed through the following lenses:

- Monthly revenue trends by customer segment
- Month-over-month (MoM) revenue decomposition
- Price vs. volume contribution analysis
- Product mix shift identification
- Segment-level revenue volatility
- Contribution of each segment to total revenue change
- Sanity checks on revenue math consistency

This framework answers questions such as:
- Which segments drive revenue growth or decline?
- Are revenue changes driven by volume or price?
- How does product mix shift affect revenue by segment?
- Which segments contribute most to revenue volatility?

Each step progresses from **baseline → decomposition → attribution → validation**.

---

## 10. Segment Monthly Revenue Base

### Purpose
Establish a clean monthly revenue baseline
for each customer segment.

### Key Metrics
- Monthly revenue by segment
- Active customers per segment

### Artifacts
- SQL: `10_segment_monthly_revenue_driver_base.sql`

### Evidence
![Segment Monthly Revenue Base](./result/10_segment_monthly_revenue_driver_base.png)  
*Baseline monthly revenue trends across customer segments*

---

## 20. Segment MoM Revenue Decomposition

### Purpose
Decompose month-over-month revenue changes
to quantify growth and decline dynamics by segment.

### Key Metrics
- MoM revenue change
- Absolute revenue delta by segment

### Artifacts
- SQL: `20_segment_mom_driver_decomposition.sql`

### Evidence
![Segment MoM Revenue Decomposition](./result/20_segment_mom_driver_decomposition.png)  
*Month-over-month revenue changes broken down by segment*

---

## 30. Price vs. Volume Mix Analysis

### Purpose
Identify whether revenue changes are driven by
pricing behavior or customer volume changes.

### Key Metrics
- Price effect
- Volume effect
- Price–volume interaction

### Artifacts
- SQL: `30_segment_mom_price_volume_mix.sql`

### Evidence
![Price Volume Mix](./result/30_segment_mom_price_volume_mix.png)  
*Relative contribution of price and volume effects by segment*

---

## 40. Product Mix Shift Analysis

### Purpose
Detect changes in product composition
that influence revenue independently of price or volume.

### Key Metrics
- Product mix contribution
- Revenue impact from assortment shifts

### Artifacts
- SQL: `40_segment_product_mix_shift.sql`

### Evidence
![Product Mix Shift](./result/40_segment_product_mix_shift.png)  
*Revenue impact from product mix changes by segment*

---

## 50. Segment Revenue Volatility

### Purpose
Assess revenue stability and risk
by measuring volatility across segments.

### Key Metrics
- Revenue variance by segment
- Relative volatility ranking

### Artifacts
- SQL: `50_segment_revenue_volatility.sql`

### Evidence
![Segment Revenue Volatility](./result/50_segment_revenue_volatility.png)  
*Revenue volatility comparison across customer segments*

---

## 60. Segment Contribution to Total MoM Change

### Purpose
Quantify how much each segment contributes
to overall monthly revenue movement.

### Key Metrics
- Segment contribution ratio
- Share of total revenue change

### Artifacts
- SQL: `60_segment_contribution_to_total_mom.sql`

### Evidence
![Segment Contribution](./result/60_segment_contribution_to_total_mom.png)  
*Segment-level contribution to total month-over-month revenue change*

---

## 70. Top Change Months per Segment

### Purpose
Highlight periods of extreme revenue change
to identify structural shifts or anomalous events.

### Key Metrics
- Largest positive and negative MoM changes
- Segment-specific shock periods

### Artifacts
- SQL: `70_top_change_months_per_segment.sql`

### Evidence
![Top Change Months](./result/70_top_change_months_per_segment.png)  
*Months with the largest revenue changes by segment*

---

## 80. Revenue Driver Summary

### Purpose
Consolidate revenue driver findings
into a single, interpretable summary view.

### Key Metrics
- Dominant revenue driver by segment
- Direction and magnitude of impact

### Artifacts
- SQL: `80_segment_driver_summary.sql`

### Evidence
![Revenue Driver Summary](./result/80_segment_driver_summary.png)  
*Primary revenue drivers identified for each customer segment*

---

## 90. Sanity & Validation Checks

### Purpose
Validate revenue math integrity
and ensure decomposition consistency.

### Validation Areas
- MoM revenue reconciliation
- Driver contribution sum checks
- Segment-level aggregation accuracy

### Artifacts
- SQL: `90_sanity_check_driver_math.sql`

### Evidence
![Driver Math Sanity Check](./result/90_sanity_check_driver_math.png)  
*Verification that revenue drivers reconcile to observed changes*

---

## Key Insights

- Revenue dynamics differ substantially by customer segment.
- Growth segments are primarily driven by **volume expansion**,
  while declining segments show price sensitivity and mix deterioration.
- A small number of segments account for the majority of revenue volatility.
- Product mix shifts can materially impact revenue even when
  overall customer volume remains stable.

---

## Why Revenue Driver Analysis Matters

This analysis supports:

- Segment-specific growth strategy design
- Pricing and promotion effectiveness evaluation
- Revenue risk identification
- Executive-level revenue diagnostics

> Revenue growth is not a single number —  
> **it is the outcome of multiple interacting drivers**.

---

## Dependencies

This module depends on:

- [Data Foundation](../../data_foundation/README.md)
- [Data Modeling](../../data_modeling/README.md)
- [Customer Segmentation](../05_ltv_analysis/README.md)

All inputs are validated prior to analysis.

---

## Execution Order

1. Establish segment-level revenue baseline
2. Decompose month-over-month revenue changes
3. Attribute changes to price, volume, and mix
4. Identify volatility and contribution patterns
5. Validate revenue math consistency

---

## Next Steps

- Integrate promotional and campaign data
- Link revenue drivers to cohort-level retention
- Feed revenue diagnostics into forecasting models and BI dashboards
