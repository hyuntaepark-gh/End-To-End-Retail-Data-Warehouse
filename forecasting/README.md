# 📈 Orders Forecasting (Time Series Analysis)

> End-to-End SQL + Time Series Forecasting Pipeline for Business Decision Making

---

## 📌 Overview

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

✔ Fully reproducible  
✔ ML-ready dataset  
✔ Traceable from raw data → prediction → insight  

---

## 🧱 SQL Pipeline

The forecasting layer is built on top of a structured SQL pipeline:

- Feature Engineering (01–06)
- Training Dataset (10–12)
- Data Validation (20–23)
- Analysis (30–34)
- Prediction Output (40–42)

This ensures:

- Consistency between analytics and forecasting
- High data reliability
- Clear lineage for debugging and validation

---

## 📊 Dataset

### 📦 Order Forecasting Dataset

- Source: `data/orders_monthly.csv`
- Target: `orders`

| Column | Description |
|------|------------|
| month | Time index |
| orders | Monthly order count |

---

### 💰 Revenue Scenario Dataset

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

- Converted month to datetime format
- Sorted chronologically
- Train/test split (last 6 months)

---

### Models

#### 1️⃣ Moving Average (Baseline)

- Simple and interpretable
- Performs well under limited data conditions

#### 2️⃣ SARIMA

- Captures trend and seasonality
- Performance constrained by short time series

---

## 📊 Model Evaluation

| Model | MAPE | Insight |
|------|------|--------|
| Moving Average | ~30% | Stable and reliable baseline |
| SARIMA | ~51% | Underperforms due to limited history |

---

## 📸 Results & Visualizations

### 📈 Monthly Orders Trend

![orders_trend](./result/orders_trend.jpg)

Order volume shows variability and a gradual upward trend,
highlighting the need for forecasting.

---

### 📊 Forecast vs Actual (SARIMA)

![forecast](./result/orders_forecast_vs_actual.jpg)

SARIMA struggles to capture recent spikes due to limited historical data.

---

### 📊 Forecast vs Actual (Moving Average)

![ma_forecast](./result/orders_forecast_ma.jpg)

Moving Average provides more stable and reliable forecasts under constrained data.

---

### 💰 Revenue Scenario Analysis

![revenue](./result/revenue_scenario.jpg)

Revenue projections demonstrate that:

👉 **Revenue = Orders × AOV**

Order volume is the primary driver,
while AOV remains relatively stable.

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
- Order volume is the primary driver of revenue
- Return behavior varies significantly by product segment
- Customer recency strongly correlates with churn risk

---

## 💼 Business Impact

This forecasting pipeline enables:

- 📦 Demand planning based on predicted orders
- 💰 Revenue projection using AOV assumptions
- ⚠️ Identification of high-risk products (returns)
- 👤 Detection of churn-prone customers
- 📊 Data-driven decision-making across operations and marketing

---

## 🔄 Data Flow Summary

```
Warehouse → SQL → Features → ML → Forecast → Business Insights
```

---

## ⚠️ Limitations

- Limited historical data
- No external variables (seasonality, promotions)
- SARIMA underperforms on short time series

---

## 🚀 Future Improvements

- Extend dataset to 24–36 months
- Incorporate external features (holidays, promotions)
- Apply advanced ML models (XGBoost, Prophet, LSTM)
- Enhance revenue modeling with dynamic AOV

---

## 🧾 Summary

Built a complete end-to-end forecasting pipeline combining:

- SQL-based data modeling
- Time series forecasting
- Business-driven revenue scenarios

This project focuses not only on prediction accuracy,
but on transforming forecasts into actionable business insights.
