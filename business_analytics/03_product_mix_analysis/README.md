# Product Mix Analysis

A structured product mix analysis designed to understand revenue concentration,
product performance stability, and portfolio risk using warehouse-level data.

Category: Product Strategy · Assortment Optimization · Risk Analysis

---

## Overview

This module analyzes how revenue is distributed across products
and identifies concentration risks, long-tail efficiency, and
product-level behavioral patterns.

All analyses are built on top of validated dimensional models
and are intended to support assortment strategy, pricing decisions,
and portfolio optimization.

---

## Analysis Framework

The product mix is evaluated across multiple dimensions:

- Revenue concentration (Pareto / top-N products)
- Product stability over time
- Return behavior and product risk
- Price vs volume sensitivity
- Segment-level product preferences
- Lifecycle and dependency risk

This framework is designed to answer questions such as:

- Which products truly drive sustainable revenue?
- Where does product concentration create operational or revenue risk?
- Which SKUs should be expanded, optimized, or sunset?

Each step progressively deepens understanding
from descriptive metrics to strategic insights.

---

## 10. Product Base Metrics

### Purpose

Establish baseline product-level KPIs to anchor all downstream analysis.

### Key Metrics

- Revenue by product
- Order count
- Quantity sold
- Average selling price

### Evidence

![Product Base Metrics](./result/10_product_base_metrics.png)

Artifacts:
- 10_product_base_metrics.sql

---

## 20. Top Products by Revenue

### Purpose

Identify top-performing products and quantify
how much revenue is driven by a small subset of SKUs.

### Key Metrics

- Revenue ranking
- Cumulative revenue contribution

### Evidence

![Top Products by Revenue](./result/20_top_products_by_revenue.png)

Artifacts:
- 20_top_products_by_revenue.sql

---

## 30. Revenue Concentration (Pareto Analysis)

### Purpose

Measure revenue concentration and validate the Pareto principle
within the product portfolio.

### Key Metrics

- Cumulative revenue percentage
- Product concentration curve

### Evidence

![Revenue Concentration Pareto](./result/30_product_concentration_pareto.png)

Artifacts:
- 30_product_concentration_pareto.sql

---

## 40. Segment-Level Product Preference

### Purpose

Understand how different customer segments
exhibit distinct product preferences.

### Key Metrics

- Revenue share by segment and product
- Segment-specific top products

### Evidence

![Segment Product Preference](./result/40_segment_product_preference.png)

Artifacts:
- 40_segment_product_preference.sql

---

## 50. Product Return Rate Analysis

### Purpose

Identify products with disproportionately high return rates
that may signal quality, pricing, or expectation mismatch issues.

### Key Metrics

- Return rate by product
- Revenue impact of returns

### Evidence

![Product Return Rate](./result/50_product_return_rate.png)

Artifacts:
- 50_product_return_rate.sql

---

## 60. Product Sales Stability

### Purpose

Assess how stable product performance is over time
to distinguish core products from volatile ones.

### Key Metrics

- Revenue variance
- Sales volatility indicators

### Evidence

![Product Sales Stability](./result/60_product_sales_stability.png)

Artifacts:
- 60_product_sales_stability.sql

---

## 70. Price vs Volume Effect

### Purpose

Determine whether product revenue is driven more by
pricing power or sales volume.

### Key Metrics

- Price sensitivity proxy
- Volume-driven vs price-driven products

### Evidence

![Price vs Volume Effect](./result/70_product_price_vs_volume_effect.png)

Artifacts:
- 70_product_price_vs_volume_effect.sql

---

## 80. Segment-Level Product Concentration

### Purpose

Evaluate whether revenue concentration risk
differs by customer segment.

### Key Metrics

- Segment-level concentration ratios
- Dependency on top products by segment

### Evidence

![Segment Product Concentration](./result/80_segment_product_concentration.png)

Artifacts:
- 80_segment_product_concentration.sql

---

## 85. SKU Portfolio Classification

### Purpose

Classify products into strategic portfolio buckets
such as core, niche, risky, and opportunistic.

### Evidence

![SKU Portfolio Classification](./result/85_sku_portfolio_classification.png)

Artifacts:
- 85_sku_portfolio_classification.sql

---

## 86. Long-Tail Product Efficiency

### Purpose

Assess whether long-tail products collectively
contribute meaningful revenue relative to operational overhead.

### Evidence

![Long Tail Product Efficiency](./result/86_long_tail_product_efficiency.png)

Artifacts:
- 86_long_tail_product_efficiency.sql

---

## 88. Product Lifecycle Stage Analysis

### Purpose

Analyze products across lifecycle stages
including introduction, growth, maturity, and decline.

### Evidence

![Product Lifecycle Stage](./result/88_product_lifecycle_stage_analysis.png)

Artifacts:
- 88_product_lifecycle_stage_analysis.sql

---

## 89. Price Sensitivity Proxy Analysis

### Purpose

Approximate product-level price sensitivity
using observed revenue and volume patterns.

### Evidence

![Price Sensitivity Proxy](./result/89_price_sensitivity_proxy_analysis.png)

Artifacts:
- 89_price_sensitivity_proxy_analysis.sql

---

## 90. Sanity and Validation Checks

### Purpose

Ensure analytical correctness and consistency
before interpreting business results.

### Validation Areas

- Revenue consistency
- Negative or zero-value anomalies
- Reconciliation with warehouse facts

### Evidence

![Product Mix Sanity Checks](./result/90_sanity_checks.png)

Artifacts:
- 90_sanity_checks.sql

---

## Key Insights

- A small subset of products drives a disproportionate share of total revenue,
  creating portfolio concentration risk.
- Products with high return rates but stable sales volume often indicate
  pricing or customer expectation mismatches rather than demand issues.
- Core products demonstrate greater price resilience
  compared to long-tail or opportunistic SKUs.
- Long-tail products contribute marginal revenue individually
  but may introduce operational complexity.

---

## Derived Recommendation

Revenue concentration among a limited set of products highlights dependency risk.
Top-performing products should be actively monitored for performance stability,
while diversification and rationalization strategies should be evaluated
to reduce over-reliance on a small number of SKUs.

---

## Dependencies

This module depends on:

- ../../data_foundation/README.md
- ../../data_modeling/README.md
- ../../data_operations/README.md

All inputs are validated prior to analysis.

---

## Execution Order

1. Validate warehouse models and marts
2. Run base product metrics and rankings
3. Evaluate concentration and stability
4. Assess risk, lifecycle, and sensitivity
5. Confirm results with sanity checks

---

## Next Steps

- Integrate margin and cost data
- Add promotion and seasonality effects
- Connect insights to BI dashboards
