# Customer Segmentation Analysis (RFM-Based)

A structured customer segmentation analysis using RFM methodology
to identify high-value customers, retention opportunities, and behavioral differences
based on validated enterprise data warehouse models.

---

## Overview

This analysis segments customers using Recency, Frequency, and Monetary (RFM) metrics
to answer key business questions:

- Who are our most valuable customers?
- Which customer segments drive the majority of revenue?
- How do customer behaviors differ across segments?
- Where should retention, marketing, and operational efforts focus?

All analyses are built on top of validated enterprise data warehouse models (dw, marts)
and are designed to support actionable business decision-making, not just reporting.

---

## Segmentation Framework

Customers are segmented using the RFM framework:

- Recency (R): Days since last purchase, measured against the dataset end date
- Frequency (F): Number of distinct completed orders
- Monetary (M): Net revenue contribution (returns excluded)

Each metric is standardized using quintile ranking (NTILE(5))
to normalize customer behavior and ensure comparability across segments
without relying on arbitrary thresholds.

### Scoring Direction

- Recency score: 5 = most recent customers (lower days since last purchase)
- Frequency score: 5 = highest order frequency
- Monetary score: 5 = highest revenue contribution

Customers are assigned to business-interpretable segments
using fixed, explainable RFM rules rather than black-box clustering techniques.

---

## 10. Customer Base Metrics

### Purpose

Establish customer-level baseline metrics used for all downstream segmentation logic.

### Key Metrics

- Orders per customer
- Revenue per customer (net of returns)
- Average order value (AOV)
- First and last purchase dates

### Evidence

![Customer Base Metrics](./result/10_customer_base_metrics.png)

Artifacts:
- 10_customer_base_metrics.sql

---

## 20. RFM Scoring

### Purpose

Calculate Recency, Frequency, and Monetary values for each customer
and convert them into standardized RFM scores using quintile-based ranking.

Quintile scoring ensures robustness against outliers
and avoids reliance on manually tuned thresholds.

### Evidence

![RFM Scoring](./result/20_rfm_scoring.png)

Artifacts:
- 20_rfm_scoring.sql

---

## 30. Segmentation Definition

### Purpose

Define customer segments using clear and explainable RFM score rules.

### Segment Rules

| Segment    | RFM Rule                          |
|-----------|-----------------------------------|
| VIP        | R >= 4 AND F >= 4 AND M >= 4       |
| Loyal      | R >= 4 AND F >= 4 AND M <= 3       |
| Regular    | R = 3 AND F = 3                   |
| Low Value  | F <= 2 AND M <= 2                 |

These rule-based segments are transparent, auditable, and business-friendly.

### Evidence

![Segmentation Definition](./result/30_segmentation_definition.png)

Artifacts:
- 30_segmentation_definition.sql

---

## 31. Segment Size Distribution

### Purpose

Understand the size and composition of each customer segment.

### Evidence

![Segment Distribution](./result/31_segment_size_distribution.png)

Artifacts:
- 31_segment_size_distribution.sql

---

## 40. Segment KPI Summary

### Purpose

Compare core performance metrics across customer segments.

### Key Metrics

- Customers per segment
- Orders per customer
- Average order value (AOV)
- Revenue per customer
- Total segment revenue

### Evidence

![Segment KPI Summary](./result/40_segment_kpi_summary.png)

Artifacts:
- 40_segment_kpi_summary.sql

---

## 41. Revenue Contribution by Segment

### Purpose

Identify which customer segments contribute most to total revenue.

### Evidence

![Revenue Contribution](./result/41_segment_revenue_contribution.png)

Artifacts:
- 41_segment_revenue_contribution.sql

---

## 42. Returns Impact by Segment

### Purpose

Evaluate how return behavior differs across customer segments
and how it impacts revenue quality.

High-value segments generate the most revenue
but also exhibit higher return rates.

### Evidence

![Returns Impact](./result/42_segment_return_impact.png)

Artifacts:
- 42_segment_return_impact.sql

---

## 43. Recency Validation

### Purpose

Validate recency behavior using the dataset end date
to avoid distortion from current-date calculations.

### Evidence

![Recency Validation](./result/43_segment_recency_validation.png)

Artifacts:
- 43_segment_recency_validation.sql

---

## 50. Top Products by Segment

### Purpose

Identify top-performing products within each customer segment
to support targeted merchandising and cross-sell strategies.

### Evidence

![Top Products by Segment](./result/50_segment_top_products.png)

Artifacts:
- 50_segment_top_products.sql

---

## 60. Repeat Purchase Rate by Segment

### Purpose

Measure customer retention strength using repeat purchase rates.

Repeat customers are defined as customers
with two or more distinct completed orders.

### Evidence

![Repeat Purchase Rate](./result/60_segment_repeat_rate.png)

Artifacts:
- 60_segment_repeat_rate.sql

---

## 70. Product Affinity by Segment

### Purpose

Analyze product affinity patterns within customer segments
to identify bundling and upsell opportunities.

### Evidence

![Product Affinity](./result/70_segment_product_affinity.png)

Artifacts:
- 70_segment_product_affinity.sql

---

## 80. Segment Performance Over Time

### Purpose

Analyze how revenue, order volume, and active customers
evolve over time for each customer segment.

### Methodology

Customer segments are defined once using full-period RFM scores
and treated as static behavioral cohorts.

### Metrics

- Monthly revenue
- Monthly order count
- Active customers per segment

### Evidence

![Segment Performance Over Time](./result/80_segment_trend_over_time.png)

Artifacts:
- 80_segment_trend_over_time.sql

---

## 90. Sanity and Validation Checks

### Purpose

Ensure segmentation completeness and revenue consistency
before interpreting business results.

### Checks Performed

- Customer coverage validation
- Revenue reconciliation across segments

### Evidence

![Sanity Checks](./result/90_sanity_checks.png)

Artifacts:
- 90_sanity_checks.sql

---

## Key Insights

- VIP and Loyal customers represent a small portion of the customer base
  but contribute a disproportionate share of total revenue.
- High-value segments also exhibit higher return rates,
  highlighting operational cost considerations.
- Low Value customers show weak repeat purchase behavior.
- Recency validation confirms clear behavioral separation across segments.

---

## Derived Recommendation

Decision directly supported by this analysis:

A small number of customer segments (VIP and Loyal) contribute disproportionately
to total revenue, indicating that targeted retention strategies are likely to
deliver higher ROI than broad-based acquisition efforts.

Note (Cross-analysis context):
The broader revenue driver analysis found that revenue variability is driven primarily
by changes in order volume rather than pricing, suggesting demand stimulation initiatives
should be prioritized over price adjustments.

---

## Dependencies

- ../../data_foundation/README.md
- ../../data_modeling/README.md
- ../../data_operations/README.md

---

## Next Steps

- Track segment migration using rolling RFM windows
- Integrate segments into campaign performance analysis
- Extend segmentation to margin and profitability metrics

---

## SQL Artifacts Overview

This analysis includes SQL scripts covering:

- Customer base metrics and RFM feature engineering
- Rule-based segmentation definition
- Segment-level KPI aggregation
- Revenue, return, recency, and retention analysis
- Sanity and reconciliation checks
