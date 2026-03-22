# 📈 Orders Forecasting (Time Series Analysis)

> End-to-End SQL + Time Series Forecasting Pipeline for Business Decision Making

---

## Overview

This module builds a complete end-to-end forecasting pipeline combining:

- SQL-based feature engineering
- ML-ready dataset preparation
- Time series forecasting models
- Business-oriented revenue scenario analysis

The goal is to extend descriptive analytics into forward-looking insights,
enabling better business planning and decision-making.

---

## 🧱 End-to-End Pipeline

The forecasting system is built as a structured pipeline:

```
dw.v_sales_enriched
↓
SQL Feature Engineering (01–06)
↓
Training Dataset (10–12)
↓
Data Validation (20–23)
↓
Analysis / Insights (30–34)
↓
Prediction Output (40–42)
↓
Python Forecasting Models
↓
Revenue Scenario Analysis
```

---

## 🧱 SQL Pipeline (Updated)

The forecasting system is built on a structured SQL pipeline:

- Feature Engineering (01–06)
- Training Dataset (10–12)
- Data Validation (20–23)
- Analysis (30–34)
- Prediction Output (40–42)

This ensures the pipeline is:

- Reproducible
- ML-ready
- Fully traceable from raw data to prediction

---

## 📊 Dataset

### Order Forecasting Dataset

- Source: `data/orders_monthly.csv`
- Target: `orders`

| Column | Description |
|------|------------|
| month | Time index |
| orders | Monthly order count |

---

### Revenue Scenario Dataset

- Source: `data/monthly_kpi.csv`

| Column | Description |
|-------|------------|
| month | Time index |
| revenue | Total revenue |
| orders | Number of orders |
| aov | Average order value |

---

## ⚙️ Methodology

### Data Preparation

- Converted month to datetime
- Sorted chronologically
- Train/test split (last 6 months)

---

### Models

#### 1️⃣ Moving Average (Baseline)

- Simple and interpretable
- Stable under limited data

#### 2️⃣ SARIMA

- Captures trend and seasonality
- Performance limited by short time series

---

## 📊 Model Evaluation

| Model | MAPE | Insight |
|------|------|--------|
| Moving Average | ~30% | Stable baseline |
| SARIMA | ~51% | Limited by short time series |

---

## 📸 Results & Visualizations

### 📈 Monthly Orders Trend

![orders_trend](./result/orders_trend.jpg)

Order volume shows variability and an upward trend, motivating forecasting.

---

### 📊 Forecast vs Actual (SARIMA)

![forecast](./result/orders_forecast_vs_actual.jpg)

SARIMA struggles to capture recent spikes due to limited historical data.

---

### 📊 Forecast vs Actual (Moving Average)

![ma_forecast](./result/orders_forecast_ma.jpg)

Moving Average provides more stable and reliable forecasts.

---

### 💰 Revenue Scenario Analysis

![revenue](./result/revenue_scenario.jpg)

Revenue projections highlight that **order volume is the primary driver**, while AOV remains relatively stable.

---

## 📊 SQL Validation & Feature Outputs

### Data Coverage

![coverage](./result/20_validation_data_coverage_sample.jpg)

---

### Lag Feature Validation

![lag](./result/21_validation_null_check.jpg)

---

### Return Distribution

![return](./result/23_validation_return_distribution.jpg)

---

## 📊 Business Insights

### Return Risk by Price Band

![return_rate](./result/30_analysis_return_rate_by_price_band.jpg)

---

### High Risk Products

![high_risk](./result/31_analysis_high_risk_products.jpg)

---

### Customer Churn Distribution

![churn](./result/32_analysis_churn_distribution.jpg)

---

## 💡 Key Insights

- Simple models outperform complex models under limited data conditions
- Order volume is the primary revenue driver
- Return behavior varies significantly by product segment
- Customer recency strongly correlates with churn

---

## 💼 Business Impact

This forecasting pipeline enables:

- Accurate demand planning
- Revenue projection using AOV assumptions
- Identification of high-risk products and churn-prone customers
- Data-driven decision-making for operations and marketing

---

## 🔄 Data Flow Summary

```
Warehouse → SQL → Features → ML → Forecast → Business Insights
```

---


---

## ⚠️ Limitations

- Limited historical data
- No external variables (seasonality, promotions)
- SARIMA underperforms with short series

---

## 🚀 Future Improvements

- Extend dataset to 24–36 months
- Add external features (holiday, promotions)
- Apply ML models (XGBoost, Prophet)
- Improve revenue modeling

---

## 🧾 Summary

Built a complete end-to-end forecasting pipeline combining SQL, time series modeling, and business scenario analysis.

The project focuses not only on prediction accuracy,
but on transforming forecasts into actionable business insights.
