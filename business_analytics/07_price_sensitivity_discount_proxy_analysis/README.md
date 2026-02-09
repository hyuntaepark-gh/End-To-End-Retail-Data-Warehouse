# Price Sensitivity and Discount Proxy Analysis

A structured price sensitivity analysis designed to understand
how different customer segments respond to price changes and
discount-like signals using observational proxies.

Category: Pricing Analytics · Revenue Optimization · Customer Segmentation

---

## Overview

This module analyzes segment-level price sensitivity
by examining the relationship between price movements,
quantity response, and revenue volatility.

Rather than relying on controlled pricing experiments,
this analysis uses observed behavioral and statistical proxies
to infer how different customer segments react to
price changes and discount signals.

Understanding these dynamics enables more effective pricing
and promotion decisions that balance revenue growth
with margin protection.

---

## Why This Analysis Matters

- Prevent margin erosion from undifferentiated discounting
- Identify segments that respond strongly to price or discount signals
- Design segment-specific pricing and promotion strategies
- Improve revenue forecasting using behavior-driven elasticity signals

Pricing power is not uniform.
Segment-level sensitivity determines whether price changes
drive growth or introduce risk.

---

## Analysis Framework

Price sensitivity is analyzed through the following lenses:

- Baseline price and quantity behavior by segment
- Price versus quantity response patterns
- Discount proxy indicators derived from price volatility
- Regression-based elasticity estimation
- Product-level control checks
- Sanity and mathematical validation

Each step progresses from observation
to proxy construction
to inference
to validation.

---

## 10. Segment Monthly Average Price

### Purpose

Establish baseline pricing behavior by segment
to identify structural differences in price levels and trends.

### Key Metrics

- Average unit price by segment
- Price trend stability over time

### Evidence

![Segment Monthly Average Price](./result/10_segment_monthly_avg_price.png)

Artifacts:
- 10_segment_monthly_avg_price.sql

---

## 20. Price versus Quantity Change Analysis

### Purpose

Evaluate whether price changes are associated
with observable quantity response at the segment level.

### Key Metrics

- Month-over-month price change
- Month-over-month quantity change
- Directional response patterns

### Evidence

![Price Quantity Change](./result/20_segment_price_quantity_change.png)

Artifacts:
- 20_segment_price_quantity_change.sql

---

## 30. Price Sensitivity Index

### Purpose

Construct a comparative price sensitivity index
using normalized price and quantity change behavior.

### Key Metrics

- Relative price sensitivity index
- Segment ranking by sensitivity

### Evidence

![Price Sensitivity Index](./result/30_segment_price_sensitivity_index.png)

Artifacts:
- 30_segment_price_sensitivity_index.sql

Interpretation Note:
This index is a relative comparison metric
and should not be interpreted as absolute elasticity.

---

## 40. Discount Proxy Score

### Purpose

Approximate discount-driven behavior
by identifying price volatility patterns
commonly associated with promotional activity.

### Key Metrics

- Price volatility score
- Frequency of large price drops
- Segment-level discount proxy ranking

### Evidence

![Discount Proxy Score](./result/40_segment_discount_proxy_score.png)

Artifacts:
- 40_segment_discount_proxy_score.sql

---

## 50. Price Elasticity Regression

### Purpose

Estimate statistical price elasticity
to validate proxy-based sensitivity signals.

### Key Metrics

- Elasticity coefficient
- Direction and relative magnitude of response
- Model fit indicators

### Evidence

![Price Elasticity Regression](./result/50_segment_price_elasticity_regression.png)

Artifacts:
- 50_segment_price_elasticity_regression.sql

---

## 60. Top Price Movement Months

### Purpose

Identify months with extreme price movements
to contextualize elasticity and volatility behavior.

### Key Metrics

- Largest price increase and decrease months
- Segment exposure to price shocks

### Evidence

![Top Price Move Months](./result/60_segment_top_price_move_months.png)

Artifacts:
- 60_segment_top_price_move_months.sql

---

## 70. Same-Product Price Elasticity Control

### Purpose

Control for product mix effects
by analyzing price elasticity within identical products.

### Key Metrics

- Same-product price elasticity
- Cross-segment elasticity comparison

### Evidence

![Same Product Elasticity](./result/70_segment_price_elasticity_same_product.png)

Artifacts:
- 70_segment_price_elasticity_same_product.sql

---

## 80. Log-Log Elasticity Validation

### Purpose

Validate elasticity estimates
using log-log regression for robustness.

### Key Metrics

- Log-log elasticity coefficient
- Consistency with linear model results

### Evidence

![Log Log Elasticity](./result/80_segment_price_elasticity_loglog.png)

Artifacts:
- 80_segment_price_elasticity_loglog.sql

---

## 90. Sanity and Validation Checks

### Purpose

Ensure mathematical correctness
and analytical consistency across all derived metrics.

### Validation Areas

- Price and quantity aggregation consistency
- Elasticity sign and direction validation
- Segment-level reconciliation

### Evidence

![Sanity Check](./result/90_sanity_check_driver_math.png)

Artifacts:
- 90_sanity_check_driver_math.sql

---

## Key Insights

- Price sensitivity varies meaningfully by customer segment.
- High-sensitivity segments respond better to targeted promotions
  than to permanent price reductions.
- Low-sensitivity segments tolerate moderate price increases
  with limited volume loss.
- Discount-driven segments exhibit higher revenue volatility.
- Elasticity signals are directionally consistent
  across proxy and regression-based methods.

---

## Derived Recommendation

Observed heterogeneity in price sensitivity across customer segments
indicates that selective, segment-specific discounting strategies
are more effective than broad price reductions.

---

## Dependencies

This module depends on:

- dw.fact_sales (transaction-level pricing and quantity)
- dw.dim_date (calendar reference)
- dw.dim_customer (segment attribution)
- Validated revenue and pricing aggregation logic

All inputs are validated prior to analysis.

---

## Execution Order

1. Validate pricing and quantity aggregates
2. Establish baseline price behavior by segment
3. Measure price-quantity response patterns
4. Construct sensitivity and discount proxies
5. Estimate regression-based elasticity
6. Apply product-level control checks
7. Confirm results through sanity checks

---

## Next Steps

- Integrate promotion and campaign metadata
- Combine price sensitivity with margin analysis
- Feed elasticity outputs into pricing simulations
- Apply findings to dynamic pricing or offer optimization
