# 💰 Revenue Scenario Analysis

## Overview

This module translates forecasted order volume into revenue projections
by combining predicted demand with historical business KPIs.

Instead of directly forecasting revenue,
this approach uses a simple and interpretable assumption:

Revenue = Orders × Average Order Value (AOV)

---

## Objective

The goal is to answer a key business question:

"Given predicted order volume, what is the expected revenue?"

This allows stakeholders to:
- Estimate future performance
- Plan inventory and marketing strategies
- Evaluate upside and downside scenarios

---

## Methodology

### Step 1: Load Inputs

- orders_forecast.csv  
  Predicted monthly order volume

- monthly_kpi.csv  
  Historical revenue, orders, and AOV

---

### Step 2: AOV Assumption

We assume that AOV remains relatively stable.

Forecast Revenue = Predicted Orders × Recent Average AOV

- AOV is calculated from recent historical data
- This simplifies modeling and improves interpretability

---

### Step 3: Revenue Projection

- Multiply predicted orders by AOV
- Generate future revenue estimates
- Compare with historical trends

---

## Output

| Column         | Description                    |
|---------------|--------------------------------|
| month         | Forecast month                |
| pred_orders   | Predicted order volume        |
| assumed_aov   | Assumed average order value   |
| pred_revenue  | Estimated revenue             |

---

## Key Insight

- Order volume is the primary driver of revenue change
- AOV remains relatively stable over time
- Therefore, improving demand forecasting directly improves revenue planning

---

## Business Interpretation

This approach reflects how real businesses operate:

- Demand (orders) is volatile and requires forecasting
- Pricing (AOV) tends to be stable in the short term

This enables:
- More explainable forecasting
- Easier communication with stakeholders
- Faster scenario analysis without complex models

---

## Limitations

- Assumes stable AOV (may not hold during promotions or seasonality)
- Short historical window (~13 months)
- Does not incorporate external factors (marketing, holidays)

---

## Why This Matters

This module demonstrates the transition from:

Data → Forecast → Business Decision

Instead of focusing only on model accuracy,
it emphasizes how predictions are used in real-world decision-making.

---

## Next Step

- Add AOV scenario variations (increase / decrease)
- Incorporate promotion or pricing effects
- Extend to category-level or segment-level forecasting
