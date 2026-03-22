# 📈 Orders Forecasting (Time Series Analysis)

## Overview

This module builds a forecasting pipeline to predict monthly order volume using time series models.

The goal is to extend descriptive analytics into forward-looking insights, enabling better planning and decision-making.

---

## Executive Summary

This project demonstrates how historical order data can be transformed into actionable forecasts using baseline and statistical time series models.

Two approaches are compared:

* Moving Average (baseline)
* SARIMA (time series model)

The focus is not only on prediction accuracy, but on business applicability.

---

## Business Context

Forecasting order volume is critical for:

* Revenue planning
* Inventory and supply chain optimization
* Identifying future demand trends

This model supports data-driven operational and financial decisions.

---

## Dataset

* Source: data/orders_monthly.csv
* Granularity: Monthly
* Target variable: orders

| Column | Description        |
| ------ | ------------------ |
| month  | Month (time index) |
| orders | Number of orders   |

---

## Methodology

### 1. Data Preparation

* Converted month to datetime format
* Sorted data chronologically
* Split into training and test sets (last 6 months as test)

---

### 2. Baseline Model: Moving Average

A simple model using recent historical averages.

Purpose:

* Establish a benchmark
* Provide stable and interpretable forecasts

---

### 3. SARIMA Model

A statistical time series model designed to capture:

* Trend
* Seasonality
* Temporal dependencies

Configuration:

* order = (1,1,1)
* seasonal_order = (1,1,1,12)

---

## Model Evaluation

Evaluation metric:

* Mean Absolute Percentage Error (MAPE)

| Model          | MAPE |
| -------------- | ---- |
| Moving Average | ~30% |
| SARIMA         | ~51% |

---

## Results & Insights

* Moving Average provides a stable baseline under limited data conditions
* SARIMA attempts to capture temporal patterns but is constrained by short time series
* Model performance is influenced heavily by data availability

Moving Average was selected as the primary model due to better performance and stability.

---

## SQL-Based Baseline (Additional Validation)

A SQL-based Moving Average forecast was also implemented to create a transparent baseline.

Approach:

* Aggregate monthly orders
* Compute average of last 3 months
* Use as baseline estimate

SQL Example:

```
WITH monthly_orders AS (
    SELECT
        date_trunc('month', to_date(date_key::text, 'YYYYMMDD'))::date AS month,
        COUNT(DISTINCT invoice_no) AS orders
    FROM dw.v_sales_enriched
    WHERE is_return = false
    GROUP BY 1
),
last_3_avg AS (
    SELECT AVG(orders) AS avg_orders
    FROM (
        SELECT orders
        FROM monthly_orders
        ORDER BY month DESC
        LIMIT 3
    ) t
)
SELECT avg_orders FROM last_3_avg;
```

This SQL baseline provides a simple and explainable benchmark for validating model-based forecasts.

---

## Forecast Visualization

The model outputs are visualized to compare:

* Actual values
* Moving Average predictions
* SARIMA predictions

This allows clear evaluation of model behavior.

---

## Business Interpretation

Forecasted orders can be used to:

* Estimate future revenue (Orders × AOV)
* Plan inventory levels
* Optimize marketing and promotions

This forecasting output is extended into revenue scenario analysis in a downstream module.

---

## Limitations

* Limited historical data reduces model reliability
* SARIMA requires longer time series to capture seasonality effectively
* External factors (promotions, holidays) are not included

---

## Future Improvements

* Extend dataset to 24–36 months
* Incorporate external variables
* Implement advanced models (Prophet, ML-based models)
* Improve AOV modeling and revenue forecasting

---

## Summary

Built a time series forecasting pipeline using baseline and SARIMA models to transform historical order data into actionable business insights.
