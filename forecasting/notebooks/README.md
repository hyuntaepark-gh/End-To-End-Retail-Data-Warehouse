# Forecasting Notebooks

This folder contains the notebook layer for the forecasting and machine learning workflows built on top of the retail data warehouse.

These notebooks extend the SQL-based metric and feature views into predictive and decision-support outputs.

---

## Notebook Overview

### 01_orders_forecast.ipynb
Forecasts future order volume using historical order trends.

**Purpose**
- Predict future order counts
- Establish the baseline demand forecasting layer

**Typical Inputs**
- Historical monthly order metrics
- Forecast-ready SQL outputs from the warehouse

**Typical Outputs**
- Forecasted orders
- Evaluation metrics
- Forecast charts

---

### 02_revenue_scenario.ipynb
Transforms forecasted orders into revenue scenarios using business assumptions.

**Core Logic**
- Revenue = Orders × Average Order Value (AOV)

**Purpose**
- Estimate expected future revenue
- Build baseline / upside / downside scenarios
- Support financial planning and inventory decisions

**Typical Outputs**
- Revenue projections
- Scenario comparison tables
- Scenario charts

---

### 03_churn_model.ipynb
Predicts customer churn risk using customer-level behavioral features.

**Purpose**
- Identify customers likely to stop purchasing
- Support retention and CRM targeting

**Typical Inputs**
- `ml.train_feature_customer_churn`

**Typical Outputs**
- Churn probability
- Predicted churn label
- Top at-risk customers
- Output table / CSV for BI use

---

### 04_return_risk_model.ipynb
Predicts return risk at the transaction or product level.

**Purpose**
- Estimate probability of return
- Prioritize high-risk products or orders
- Support operational risk reduction

**Typical Inputs**
- `ml.train_feature_return_risk`

**Typical Outputs**
- Return probability
- Predicted return label
- High-risk SKU / invoice list
- Output table / CSV for BI use

---

### 05_model_experiment.ipynb
Contains model comparison, feature testing, and experimental analysis.

**Purpose**
- Compare alternative models
- Evaluate feature usefulness
- Improve predictive performance

**Typical Outputs**
- Model comparison metrics
- Experiment logs
- Performance summaries

---

## End-to-End Flow

The notebook layer fits into the broader project pipeline:

Raw Data  
→ Data Foundation  
→ Data Modeling  
→ Business Analytics  
→ SQL Feature Views  
→ Notebook Models  
→ Prediction Output Tables / CSV / BI

---

## Related SQL Objects

These notebooks are designed to work with ML-ready SQL views and tables such as:

- `ml.feature_monthly_sales`
- `ml.feature_return_risk`
- `ml.feature_customer_churn`
- `ml.train_feature_monthly_sales`
- `ml.train_feature_return_risk`
- `ml.train_feature_customer_churn`
- `ml.prediction_monthly_sales`
- `ml.prediction_return_risk`
- `ml.prediction_customer_churn`

---

## Why This Layer Matters

This notebook layer shows that the project goes beyond descriptive analytics.

It demonstrates how a structured retail warehouse can support:

- demand forecasting
- revenue planning
- return risk scoring
- churn prediction
- model experimentation

This makes the project closer to a real analytics + machine learning workflow rather than a SQL-only portfolio project.
