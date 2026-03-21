# 📈 Orders Forecasting (Time Series Analysis)

## Overview

This module builds a forecasting pipeline to predict **monthly order volume**
using time series models.

The goal is to extend descriptive analytics into **forward-looking insights**,
enabling better planning and decision-making.

---

## Executive Summary

This project demonstrates how historical order data can be transformed into
actionable forecasts using baseline and statistical time series models.

Two approaches are compared:

* Moving Average (baseline)
* SARIMA (time series model)

The focus is not only on prediction accuracy, but on **business applicability**.

---

## Business Context

Forecasting order volume is critical for:

* 📈 Revenue planning
* 📦 Inventory and supply chain optimization
* 📊 Identifying future demand trends

This model supports **data-driven operational and financial decisions**.

---

## Dataset

* Source: `data/orders_monthly.csv`
* Granularity: Monthly
* Target variable: `orders`

| Column | Description        |
| ------ | ------------------ |
| month  | Month (time index) |
| orders | Number of orders   |

---

## Methodology

### 1. Data Preparation

* Converted `month` to datetime format
* Sorted data chronologically
* Split into training and test sets (last 6 months as test)

---

### 2. Baseline Model: Moving Average

A simple model using recent historical averages.

📌 Purpose:

* Establish a benchmark
* Provide stable and interpretable forecasts

---

### 3. SARIMA Model

A statistical time series model designed to capture:

* Trend
* Seasonality
* Temporal dependencies

📌 Configuration:

* order = (1,1,1)
* seasonal_order = (1,1,1,12)

---

## Model Evaluation

Evaluation metric:

* **MAPE (Mean Absolute Percentage Error)**

| Model          | MAPE |
| -------------- | ---- |
| Moving Average | XX%  |
| SARIMA         | XX%  |

---

## Results & Insights

* Moving Average provides a stable baseline under limited data conditions
* SARIMA attempts to capture temporal patterns but is constrained by short time series
* Model performance is influenced heavily by data availability

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

This bridges the gap between analytics and business strategy.

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
* Build revenue forecasting layer

---

## 🚀 Summary

> Built a time series forecasting pipeline using baseline and SARIMA models
> to transform historical order data into actionable business insights.
