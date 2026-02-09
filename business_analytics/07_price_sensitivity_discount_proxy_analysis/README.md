# Price Sensitivity & Discount Proxy Analysis

**Analyzing customer price sensitivity and discount responsiveness
using behavioral proxies and segment-level elasticity patterns.**

**Category:** Pricing Analytics · Customer Behavior · Revenue Optimization

---

## Overview

This module analyzes **how sensitive different customer segments are to price changes**
by examining purchasing behavior, quantity response, and discount-related proxies.

Because true experimental price tests are often unavailable,
this analysis relies on **observed behavioral signals**
to approximate price sensitivity and elasticity.

The goal is not perfect elasticity estimation,
but **actionable differentiation across segments**
to support pricing, discounting, and promotion strategy.

---

## Analysis Framework

Price sensitivity is analyzed through multiple complementary lenses:

- Average price trends by segment
- Price vs. quantity response
- Price sensitivity index construction
- Discount proxy behavior
- Regression-based elasticity approximation
- Product-controlled elasticity checks
- Extreme price-move period analysis

This framework answers questions such as:
- Which segments are most price sensitive?
- Who responds strongly to discounts?
- Are revenue changes driven by price or volume reaction?
- Which segments tolerate price increases best?

Each step moves from **descriptive → proxy-based → model-based validation**.

---

## 10. Segment Monthly Average Price

### Purpose
Establish baseline price levels and trends by customer segment.

### Key Metrics
- Average unit price by segment and month
- Price trend stability

### Artifacts
- `10_segment_monthly_avg_price.png`

### Evidence
![Segment Monthly Avg Price](./result/10_segment_monthly_avg_price.png)

---

## 20. Segment Price × Quantity Change

### Purpose
Observe how quantity purchased responds to price changes
at the segment level.

### Key Metrics
- Month-over-month price change
- Corresponding quantity change

### Artifacts
- `20_segment_price_quantity_change.png`

### Evidence
![Price Quantity Change](./result/20_segment_price_quantity_change.png)

Segments showing strong inverse price–quantity movement
are likely more price sensitive.

---

## 30. Price Sensitivity Index

### Purpose
Construct a normalized index to compare relative
price sensitivity across segments.

### Key Metrics
- Price sensitivity score (relative scale)
- Direction and magnitude of response

### Artifacts
- `30_segment_price_sensitivity_index.png`

### Evidence
![Price Sensitivity Index](./result/30_segment_price_sensitivity_index.png)

This index allows ranking segments from
price-inelastic to highly price-sensitive.

---

## 40. Discount Proxy Score

### Purpose
Approximate discount responsiveness using behavioral signals
such as lower realized prices and volume spikes.

### Key Metrics
- Discount proxy score
- Relative discount responsiveness

### Artifacts
- `40_segment_discount_proxy_score.png`

### Evidence
![Discount Proxy](./result/40_segment_discount_proxy_score.png)

Segments with high proxy scores are more promotion-driven
and discount-dependent.

---

## 50. Price Elasticity Regression (Approximation)

### Purpose
Estimate price elasticity using regression-based approximation
at the segment level.

### Key Metrics
- Elasticity coefficient
- Direction and strength of price response

### Artifacts
- `50_segment_price_elasticity_regression.png`

### Evidence
![Elasticity Regression](./result/50_segment_price_elasticity_regression.png)

Results are interpreted comparatively rather than absolutely,
due to observational data limitations.

---

## 60. Top Price Move Months

### Purpose
Identify extreme price movement periods
to support root-cause and event-based analysis.

### Key Metrics
- Largest positive and negative price changes
- Associated volume reactions

### Artifacts
- `60_segment_top_price_move_months.png`

### Evidence
![Top Price Move Months](./result/60_segment_top_price_move_months.png)

---

## 70. Same-Product Price Elasticity Check

### Purpose
Control for product mix by analyzing
price sensitivity within the same product set.

### Key Metrics
- Product-level price response
- Segment consistency under control conditions

### Artifacts
- `70_segment_price_elasticity_same_product.png`

### Evidence
![Same Product Elasticity](./result/70_segment_price_elasticity_same_product.png)

This step improves robustness by reducing mix bias.

---

## 80. Log-Log Elasticity Validation

### Purpose
Validate price sensitivity patterns
using a log–log functional form.

### Key Metrics
- Log-log elasticity slope
- Stability across segments

### Artifacts
- `80_segment_price_elasticity_loglog.png`

### Evidence
![Log Log Elasticity](./result/80_segment_price_elasticity_loglog.png)

---

## Key Insights

- Price sensitivity varies significantly across segments,
  making uniform pricing strategies suboptimal.

- Discount-driven segments show strong volume response
  but introduce revenue volatility.

- Premium segments exhibit lower elasticity,
  indicating higher tolerance for price increases.

- Behavioral proxy methods provide actionable insight
  even without controlled price experiments.

---

## Why This Analysis Matters

This analysis enables:

- Segment-specific pricing and discount strategies
- Smarter promotion targeting
- Reduced margin erosion from blanket discounts
- Improved revenue predictability

> Price changes affect revenue —  
> **but customer response determines the outcome**.

---

## Dependencies

This module depends on:

- Sales fact and product pricing data
- Customer segmentation outputs
- Validated revenue and quantity aggregation logic

All inputs are validated prior to analysis.

---

## Execution Order

1. Establish segment price baselines
2. Analyze price–quantity relationships
3. Build price sensitivity and discount proxies
4. Validate with regression-based elasticity
5. Control for product mix effects
6. Confirm robustness via log-log checks

---

## Next Steps

- Integrate promotion and campaign metadata
- Combine elasticity with revenue driver analysis
- Feed sensitivity scores into pricing optimization
- Extend into scenario-based price simulations
