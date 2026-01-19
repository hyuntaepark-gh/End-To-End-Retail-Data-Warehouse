# 📊 End-to-End Retail Data Warehouse & Analytics Project

## 📌 Project Overview
This project demonstrates a **full end-to-end data analytics system**, starting from raw retail transaction data and transforming it into a **decision-ready data warehouse**.

Rather than focusing on isolated analysis, the project emphasizes:
- Data pipeline design
- Dimensional modeling (Star Schema)
- SQL-based business analytics
- Demand forecasting
- Executive-level decision support

The goal is to replicate how **real-world retail / e-commerce data flows from transactional systems (ERP-like sources) into analytics and planning layers**.

---

## 🧠 Business Questions
This project is designed to answer **decision-driven business questions**, such as:

1. How do sales and order volumes change over time (weekly / monthly / seasonal)?
2. Which products and categories drive the highest repeat purchases?
3. How long do customers remain active after their first purchase?
4. How does demand vary across regions and time periods?
5. What is the expected demand in the next few weeks?
6. How can demand forecasts support inventory and replenishment planning?

---

## 🏗️ System Architecture
**Raw Data → ETL Pipeline → Data Warehouse → Analytics → Forecasting → Dashboard**

- Raw CSV files are ingested and validated
- Python-based ETL pipelines transform and clean data
- Data is loaded into a relational database using a **Star Schema**
- SQL queries generate business KPIs and insights
- Python models forecast future demand
- Dashboards present insights for decision-makers

---

## 🗂️ Data Sources
- Retail / E-commerce transactional dataset (Kaggle)
- Supplemental datasets:
  - U.S. holiday calendar
  - Weather data (optional extension)

> Raw datasets are not fully stored in this repository due to size and licensing.  
> Sample data and download instructions are provided instead.

---

## 🧱 Data Modeling (Star Schema)
The data warehouse is designed using **dimensional modeling principles**.

### Fact Tables
- `fact_order_items` – transaction-level sales data

### Dimension Tables
- `dim_product`
- `dim_customer`
- `dim_date`
- `dim_location` (if applicable)
- `dim_weather` (optional)

### Why Star Schema?
- Optimized for analytical queries
- Clear separation between facts and dimensions
- Commonly used in enterprise data warehouses and BI systems
- Aligns with ERP-to-analytics data flows

---

## 🔄 ETL Pipeline
ETL is implemented in Python with a clear separation of concerns:

### 1. Extract
- Load raw CSV files

### 2. Transform
- Data type enforcement
- Deduplication
- Missing value handling
- Key normalization

### 3. Load
- Insert into staging tables
- Load into warehouse fact and dimension tables

### Data Quality Checks
- Primary key uniqueness
- Foreign key integrity
- Null and invalid value detection
- Volume and range validation

---

## 📈 SQL Analytics
Business analytics are performed using SQL, including:

- Sales and revenue trends
- Repeat purchase and retention analysis
- Product and category performance
- Time-based and regional demand analysis

Queries are written with **readability and maintainability** in mind and structured around business questions rather than raw metrics.

---

## 🔮 Demand Forecasting
Demand forecasting is implemented using Python to support operational decision-making.

- Baseline models (moving average / seasonal patterns)
- Time-aware train-validation split
- Evaluation using MAE / MAPE
- Forecast outputs designed to support inventory planning discussions

The focus is not on maximizing model complexity, but on **practical, interpretable forecasts**.

---

## 📊 Dashboard
Dashboards summarize key insights for non-technical stakeholders:

- Executive sales overview
- Demand trends and forecasts
- Product and category performance

Dashboards are designed to reflect how analytics outputs are consumed in real business environments.

---

## 🗂️ Repository Structure

```

/data
/raw (sample or reference only)
/staging
/docs (ERD, diagrams, documentation)
/data_pipeline
/src (extract, transform, load, quality)
/sql
/ddl
/analytics
/analysis
demand_forecast.ipynb
/dashboard
README.md
requirements.txt

```

---

## 🚀 How to Run
1. Download the dataset (see Data Sources)
2. Configure database connection
3. Run the ETL pipeline
4. Execute SQL analytics queries
5. Run the forecasting notebook
6. Explore dashboards

---

## 🔧 Future Improvements
- Incremental ETL and scheduling
- Additional external data integration
- Inventory optimization modeling
- Cloud-based deployment
- Automated data quality monitoring

---

## 🎯 Key Takeaways
This project demonstrates the ability to:
- Design analytics-ready data models
- Build reliable ETL pipelines
- Translate raw data into business decisions
- Bridge analytics, engineering, and ERP-style thinking
