# Product Mix Analysis

**A structured product mix analysis designed to understand revenue concentration,
product performance stability, and portfolio risk using warehouse-level data.**

---

## Overview

This module analyzes **how revenue is distributed across products**
and identifies concentration risks, long-tail efficiency, and
product-level behavioral patterns.

All analyses are built on top of validated dimensional models
and are intended to support **assortment strategy, pricing decisions,
and portfolio optimization**.

---

## Analysis Framework

The product mix is evaluated across multiple dimensions:

- Revenue concentration (Pareto / top-N products)
- Product stability over time
- Return behavior and risk
- Price vs. volume sensitivity
- Segment-level product preferences
- Lifecycle and dependency risk

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

### Artifacts
- `10_product_base_metrics.sql`

### Evidence
![Product Base Metrics](./result/10_product_base_metrics.png)

---

## 20. Top Products by Revenue

### Purpose
Identify top-performing products and understand
how much revenue is driven by a small subset of SKUs.

### Key Metrics
- Revenue ranking
- Cumulative revenue contribution

### Artifacts
- `20_top_products_by_revenue.sql`

### Evidence
![Top Products by Revenue](./result/20_top_products_by_revenue.png)

---

## 30. Revenue Concentration (Pareto Analysis)

### Purpose
Measure revenue concentration and validate the 80/20 rule
within the product portfolio.

### Key Metrics
- Cumulative revenue %
- Product concentration curve

### Artifacts
- `30_product_concentration_pareto.sql`

### Evidence
![Revenue Concentration Pareto](./result/30_product_concentration_pareto.png)

---

## 40. Segment-Level Product Preference

### Purpose
Understand how different customer segments
exhibit distinct product preferences.

### Key Metrics
- Revenue share by segment & product
- Segment-specific top products

### Artifacts
- `40_segment_product_preference.sql`

### Evidence
![Segment Product Preference](./result/40_segment_product_preference.png)

---

## 50. Product Return Rate Analysis

### Purpose
Identify products with disproportionately high return rates
that may signal quality or expectation mismatch issues.

### Key Metrics
- Return rate by product
- Revenue impact of returns

### Artifacts
- `50_product_return_rate.sql`

### Evidence
![Product Return Rate](./result/50_product_return_rate.png)

---

## 60. Product Sales Stability

### Purpose
Assess how stable product performance is over time
to distinguish core products from volatile ones.

### Key Metrics
- Revenue variance
- Sales volatility indicators

### Artifacts
- `60_product_sales_stability.sql`

### Evidence
![Product Sales Stability](./result/60_product_sales_stability.png)

---

## 70. Price vs. Volume Effect

### Purpose
Determine whether product revenue is driven more by
pricing power or sales volume.

### Key Metrics
- Price sensitivity proxy
- Volume-driven vs. price-driven products

### Artifacts
- `70_product_price_vs_volume_effect.sql`

### Evidence
![Price vs Volume Effect](./result/70_product_price_vs_volume_effect.png)

---

## 80. Segment-Level Product Concentration

### Purpose
Evaluate whether revenue concentration risk
differs by customer segment.

### Key Metrics
- Segment-level concentration ratios
- Dependency on top products by segment

### Artifacts
- `80_segment_product_concentration.sql`

### Evidence
![Segment Product Concentration](./result/80_segment_product_concentration.png)

---

## 85. SKU Portfolio Classification

### Purpose
Classify products into strategic portfolio buckets
(e.g., core, niche, risky, opportunistic).

### Artifacts
- `85_sku_portfolio_classification.sql`

### Evidence
![SKU Portfolio Classification](./result/85_sku_portfolio_classification.png)

---

## 86. Long-Tail Product Efficiency

### Purpose
Assess whether long-tail products collectively
contribute meaningful revenue or operational overhead.

### Artifacts
- `86_long_tail_product_efficiency.sql`

### Evidence
![Long Tail Product Efficiency](./result/86_long_tail_product_efficiency.png)

---

## 88. Product Lifecycle Stage Analysis

### Purpose
Analyze products across lifecycle stages
(introduction, growth, maturity, decline).

### Artifacts
- `88_product_lifecycle_stage_analysis.sql`

### Evidence
![Product Lifecycle Stage](./result/88_product_lifecycle_stage_analysis.png)

---

## 89. Price Sensitivity Proxy Analysis

### Purpose
Approximate product-level price sensitivity
using observed revenue and volume patterns.

### Artifacts
- `89_price_sensitivity_proxy_analysis.sql`

### Evidence
![Price Sensitivity Proxy](./result/89_price_sensitivity_proxy_analysis.png)

---

## 90. Sanity & Validation Checks

### Purpose
Ensure analytical correctness before drawing conclusions.

### Validation Areas
- Revenue consistency
- Negative or zero-value anomalies
- Reconciliation with warehouse facts

### Artifacts
- `90_sanity_checks.sql`

### Evidence
![Product Mix Sanity Checks](./result/90_sanity_checks.png)

---

## Key Insights (Example)

- A small fraction of products drives the majority of revenue.
- Long-tail products contribute marginal revenue but increase complexity.
- Certain products exhibit high return rates, indicating risk.
- Core products show strong price resilience compared to peripheral SKUs.

---

## Why Product Mix Analysis Matters

This analysis supports:

- Assortment optimization
- Inventory and SKU rationalization
- Pricing and promotion strategy
- Risk management in revenue concentration

> Revenue growth is not only about selling more —
> it’s about selling the *right* products.

---

## Dependencies

This module depends on:

- [Data Foundation](../../data_foundation/README.md)
- [Data Modeling](../../data_modeling/README.md)
- [Data Operations](../../data_operations/README.md)

All inputs are validated prior to analysis.

---

## Next Steps

- Integrate margin and cost data
- Add promotion and seasonality effects
- Connect results to BI dashboards
