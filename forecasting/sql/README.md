# SQL Layer for Forecasting & Machine Learning

This folder contains all SQL scripts used to build the machine learning pipeline on top of the retail data warehouse.

The SQL layer is structured to clearly separate feature engineering, training datasets, validation, analysis, and prediction outputs.

---

## 📂 Structure Overview

### 01–06: Feature Engineering
These scripts create ML-ready feature views from the data warehouse.

- Lag features (e.g., revenue_lag1, lag2, lag3)
- Rolling metrics (e.g., 3-month, 6-month averages)
- Aggregated KPIs (orders, revenue, AOV, customers)
- Behavioral features (recency, historical return rate)

Key outputs:
- `ml.feature_monthly_sales`
- `ml.feature_return_risk`
- `ml.feature_customer_churn`

---

### 10–12: Training Datasets
These scripts prepare clean, model-ready datasets.

- Remove null values
- Filter invalid records
- Standardize feature inputs

Key outputs:
- `ml.train_feature_monthly_sales`
- `ml.train_feature_return_risk`
- `ml.train_feature_customer_churn`

---

### 20–23: Data Validation
These queries validate data quality and feature consistency.

- Null checks
- Time-series continuity
- Data coverage
- Distribution checks

Purpose:
Ensure reliability before training models

---

### 30–34: Analysis Layer
These queries provide business insights based on ML features.

Examples:
- Return rate by price band
- High-risk products identification
- Churn distribution and segmentation
- Feature-level analysis for interpretability

---

### 40–42: Prediction Output Tables
These scripts define tables for storing model outputs.

Key outputs:
- `ml.prediction_monthly_sales`
- `ml.prediction_return_risk`
- `ml.prediction_customer_churn`

These tables are populated by Python notebooks after model training.

---

## 🔁 End-to-End Flow

Raw Data  
→ Data Warehouse (DW)  
→ Feature Views (01–06)  
→ Training Views (10–12)  
→ Validation (20–23)  
→ ML Models (Notebook Layer)  
→ Prediction Tables (40–42)  
→ CSV / BI / Dashboard

---

## 💡 Why This Layer Matters

This SQL layer transforms raw transactional data into machine learning-ready datasets.

It demonstrates:

- Strong SQL-based feature engineering
- Clear separation of data pipeline stages
- Integration between data warehouse and ML workflows
- Production-style data preparation for predictive modeling

This goes beyond simple querying and reflects real-world data engineering + analytics practices.
