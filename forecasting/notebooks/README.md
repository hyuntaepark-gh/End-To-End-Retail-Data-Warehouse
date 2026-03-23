# Forecasting Notebooks

This folder contains notebook-based forecasting and machine learning workflows built on top of the retail data warehouse.

## Notebook Overview

### 01_orders_forecast.ipynb
Forecasts future order volume using historical order trends.

### 02_revenue_scenario.ipynb
Translates forecasted orders into revenue scenarios using:
Revenue = Orders × AOV

### 03_churn_model.ipynb
Predicts customer churn risk using customer-level behavioral features.

### 04_return_risk_model.ipynb
Predicts return risk at the transaction or product level.

### 05_model_experiment.ipynb
Contains model comparison, feature testing, and experimental analysis.

## End-to-End Flow

Raw Data  
→ Data Foundation  
→ Data Modeling  
→ Business Analytics  
→ SQL Feature Views  
→ Notebook Models  
→ Prediction Output Tables / CSV / BI

## Why This Layer Matters

This notebook layer shows how the warehouse supports both:
- business-driven forecasting
- machine learning prediction workflows
