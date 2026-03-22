# 📂 Data Files

This folder contains datasets used for forecasting and revenue analysis.

---

## Files

### 1. orders_monthly.csv

* Monthly aggregated order data
* Generated from SQL (data warehouse)
* Used as input for forecasting

| Column | Description        |
| ------ | ------------------ |
| month  | Month (time index) |
| orders | Number of orders   |

---

### 2. orders_forecast.csv

* Forecasted order volume
* Generated from `02_orders_forecast.ipynb`

| Column      | Description                       |
| ----------- | --------------------------------- |
| month       | Forecast month                    |
| pred_orders | Predicted orders                  |
| model       | Model used (e.g., Moving Average) |

---

### 3. monthly_kpi.csv

* Monthly KPI dataset for revenue scenario analysis
* Generated from SQL (data warehouse)
* Used in `03_revenue_scenario.ipynb`

| Column  | Description                     |
|--------|---------------------------------|
| month  | Month (time index)              |
| revenue| Total revenue                   |
| orders | Number of orders                |
| aov    | Average Order Value (revenue / orders) |

---

## Data Flow

SQL (dw.v_sales_enriched)

├── orders_monthly.csv  
│   → Forecast Model  
│   → orders_forecast.csv  

└── monthly_kpi.csv  
    → Revenue Scenario Analysis  

---

## Notes

* Forecast results are based on Moving Average baseline
* Dataset is limited to short time series (~13 months)
* Used for demonstration of forecasting pipeline
* Revenue scenario assumes relatively stable AOV
* Revenue forecast is derived from forecasted orders combined with stable AOV assumption
