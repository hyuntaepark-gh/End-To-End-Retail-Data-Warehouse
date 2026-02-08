# Revenue Driver Analysis

**A structured revenue driver analysis that decomposes revenue changes into
clear, explainable business factors using data from the enterprise data warehouse.**

---

## Overview

This analysis investigates **what drives revenue growth and decline**
by decomposing revenue into its fundamental components and examining
changes across time, geography, and customer mix.

All analyses are built on top of validated dimensional models (`dw`, `marts`)
and are designed to support **business decision-making**, not just reporting.

---

## Analysis Framework

Revenue is analyzed using the following decomposition logic:

Revenue
= Orders × Average Order Value (AOV)
= Orders × (Basket Size × Unit Price)

The analysis proceeds step by step, isolating the impact of:
- Time-based changes
- Volume vs. price effects
- Geography
- Customer mix and growth composition
- Returns and data sanity

---

## 10. Baseline Metrics

### Purpose
Establish baseline KPIs to provide context for all downstream analysis.

### Key Metrics
- Total revenue
- Total orders
- Average order value (AOV)
- Average unit price

### Artifacts
- `10_base_metrics.sql`
- `10_base_metrics.png`

---

## 20. Revenue Change Over Time (MoM)

### Purpose
Measure how revenue changes month-over-month to identify growth or decline trends.

### Key Metrics
- Monthly revenue
- Month-over-month (MoM) revenue change

### Artifacts
- `20_revenue_mom_change.sql`
- `20_revenue_mom_change.png`

---

## 30. Revenue Decomposition: Orders × AOV

### Purpose
Decompose revenue changes into:
- Changes driven by order volume
- Changes driven by average order value

### Key Metrics
- Orders effect
- AOV effect

### Artifacts
- `30_decomposition_orders_aov.sql`
- `30_decomposition_orders_aov.png`

---

## 31. AOV Decomposition: Basket Size vs. Price

### Purpose
Further decompose AOV to distinguish between:
- Basket size (quantity per order)
- Unit price effects

### Key Metrics
- Basket size effect
- Unit price effect

### Artifacts
- `31_decomposition_basket_price.sql`
- `31_decomposition_basket_price.png`

---

## 32. Volume vs. Price Contribution

### Purpose
Quantify the relative contribution of sales volume versus pricing
to overall revenue changes.

### Key Metrics
- Volume-driven revenue change
- Price-driven revenue change

### Artifacts
- `32_volume_vs_price_effect.sql`
- `32_volume_vs_price_effect.png`

---

## 40. Country-Level Revenue Drivers

### Purpose
Identify which countries contribute most to revenue
and how geographic mix influences growth.

### Key Metrics
- Revenue by country
- Country contribution to total revenue change

### Artifacts
- `40_country_revenue_driver.sql`
- `40_country_revenue_driver.png`

---

## 41. Country Drivers: Orders vs. AOV

### Purpose
Determine whether country-level revenue differences
are driven by order volume or order value.

### Key Metrics
- Orders effect by country
- AOV effect by country

### Artifacts
- `41_country_orders_aov_driver.sql`
- `41_country_orders_aov_driver.png`

---

## 50. Customer Mix Effect

### Purpose
Assess how changes in customer composition
impact overall revenue performance.

### Key Metrics
- Revenue contribution by customer segment
- Customer mix effect on revenue

### Artifacts
- `50_customer_mix_effect.sql`
- `50_customer_mix_effect.png`

---

## 51. Growth Attribution: New vs. Existing Customers

### Purpose
Attribute revenue growth to:
- New customers
- Existing customers

### Key Metrics
- Revenue from new customers
- Revenue from existing customers

### Artifacts
- `51_growth_attribution_new_vs_existing.sql`
- `51_growth_attribution_new_vs_existing.png`

---

## 52. Revenue Split: New vs. Existing Customers

### Purpose
Provide a direct comparison of revenue levels
between new and existing customers.

### Artifacts
- `52_new_vs_existing_revenue.sql`
- `52_new_vs_existing_revenue.png`

---

## 60. Returns Impact on Revenue

### Purpose
Evaluate how product returns affect net revenue
and distort gross sales trends.

### Key Metrics
- Revenue lost due to returns
- Return rate impact

### Artifacts
- `60_returns_impact.sql`
- `60_returns_impact.png`

---

## 90. Sanity & Validation Checks

### Purpose
Ensure analytical correctness and consistency
before interpreting business results.

### Validation Areas
- Negative or zero revenue checks
- Quantity and price validity
- Reconciliation with warehouse facts

### Artifacts
- `90_sanity_checks.sql`
- `90_sanity_checks.png`

---

## Key Insights (Example)

- Revenue changes are primarily driven by **order volume**, not price increases.
- A small subset of countries accounts for a disproportionate share of revenue growth.
- Existing customers contribute more to stable revenue, while new customers drive volatility.
- Returns have a non-trivial impact on net revenue and must be accounted for in KPI reporting.

---

## Why This Analysis Matters

This revenue driver analysis enables:

- Clear attribution of revenue changes
- Better pricing and inventory decisions
- More targeted geographic and customer strategies
- Data-driven executive discussions

> Revenue is not a single number — it is the result of multiple interacting drivers.

---

## Dependencies

This analysis depends on:

- [Data Foundation](../../data_foundation/README.md)
- [Data Modeling](../../data_modeling/README.md)
- [Data Operations](../../data_operations/README.md)

All inputs are validated and reconciled before analysis.

---

## Next Steps

- Extend decomposition to promotion or campaign effects
- Integrate results into BI dashboards
- Apply the same framework to margin and profit analysis
