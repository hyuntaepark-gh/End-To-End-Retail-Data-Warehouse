# Run Order

This document describes the recommended execution order for the End-to-End Retail Data Warehouse project.

## 1. Create the Database

Make sure PostgreSQL is installed and running.

```
createdb retail_dw
psql -d retail_dw -f data_operations/00_admin/schema.sql
```

2. Run Data Foundation Layer

Execute SQL scripts in the following order:

data_foundation/10_raw
data_foundation/20_staging

This step loads raw retail data and standardizes it into analytics-ready staging tables.

3. Run Data Modeling Layer

Execute SQL scripts in:

data_modeling/

This builds the dimensional warehouse structure including fact and dimension tables.

4. Run Validation Checks

Execute SQL scripts in:

data_operations/90_tests

This step validates referential integrity, consistency, and reconciliation across layers.

5. Run Business Analytics Layer

Explore and execute SQL modules in:

business_analytics/

Recommended modules include:

Revenue Driver Analysis
Customer Segmentation
Product Mix Analysis
Returns Analysis
LTV Analysis
Cohort Retention
Operational Risk Analysis
Metric Layer

6. Run Forecasting Layer

Move to the forecasting directory and run the Python script:
```
cd forecasting
python main.py
```

This generates forward-looking order and revenue predictions based on historical warehouse outputs.

Notes
Run SQL scripts in logical order within each folder.
Ensure required Python libraries are installed before running forecasting.
Refer to each layer's README for additional implementation details.
