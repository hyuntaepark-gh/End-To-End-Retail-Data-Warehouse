# 🧱 SQL Data Preparation

This folder contains SQL scripts used to generate forecasting datasets.

---

## Files

### 1. 01_monthly_orders.sql

- Aggregates transactional data into monthly order counts
- Source: dw.v_sales_enriched
- Excludes returned transactions

---

### 2. 02_monthly_orders_timeseries.sql

- Creates continuous monthly time series
- Handles missing months using generate_series
- Ensures model-ready dataset

---

## Data Pipeline

dw.v_sales_enriched  
→ Monthly Aggregation  
→ Time Series Construction  
→ orders_monthly.csv  

---

## Purpose

- Provide clean, structured input data for forecasting models  
- Ensure data consistency and reproducibility  
- Bridge raw data and analytical modeling  
