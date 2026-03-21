# 📊 Monthly Orders Time Series Preparation

## Overview

This module prepares a clean and structured **monthly orders time series dataset**
from the retail data warehouse, designed for forecasting and business analysis.

The objective is to transform raw transactional data into a **model-ready time series**,
enabling trend analysis, seasonality detection, and demand forecasting.

---

## Executive Summary

This project demonstrates how raw transactional data can be transformed into
a structured time series dataset that supports **forecasting, KPI tracking, and business decision-making**.

---

## Business Context

Understanding order volume over time is critical for:

* 📈 Revenue forecasting
* 📦 Inventory and supply planning
* 📊 Identifying growth trends and seasonal patterns

This dataset serves as the **foundation for forecasting models and executive decision-making**.

---

## Why This Matters

Transforming raw transactional data into a structured time series enables:

* Reliable forecasting inputs
* Consistent KPI tracking over time
* Alignment between data engineering and business analytics

This step bridges the gap between raw data and predictive modeling.

---

## Data Source

* Source table: `dw.v_sales_enriched`
* Filter:

  * Excludes returned transactions (`is_return = false`)
* Time granularity:

  * Monthly aggregation

---

## Step 1: Monthly Orders Aggregation

```sql
SELECT
  date_trunc('month', to_date(date_key::text, 'YYYYMMDD'))::date AS month,
  COUNT(DISTINCT invoice_no) AS orders
FROM dw.v_sales_enriched
WHERE is_return = false
GROUP BY 1
ORDER BY 1;
```

📌 Example Output:

| month      | orders |
| ---------- | ------ |
| 2010-12-01 | 1400   |
| 2011-01-01 | 987    |
| ...        | ...    |

---

## Step 2: Complete Time Series Construction

```sql
WITH bounds AS (
    SELECT
        MIN(make_date(year, month, 1)) AS min_month,
        MAX(make_date(year, month, 1)) AS max_month
    FROM dw.v_sales_enriched
    WHERE is_return = false
),
months AS (
    SELECT generate_series(min_month, max_month, interval '1 month')::date AS month
    FROM bounds
),
orders AS (
    SELECT
        make_date(year, month, 1) AS month,
        COUNT(DISTINCT invoice_no) AS orders
    FROM dw.v_sales_enriched
    WHERE is_return = false
    GROUP BY 1
)
SELECT
    m.month,
    COALESCE(o.orders, 0) AS orders
FROM months m
LEFT JOIN orders o USING (month)
ORDER BY 1;
```

📌 Key Features:

* Ensures **continuous monthly time series**
* Handles missing months with `0` orders
* Produces a **model-ready dataset**

---

## Output Dataset

Saved as:

```
data/orders_monthly.csv
```

| Column | Description             |
| ------ | ----------------------- |
| month  | First day of each month |
| orders | Number of unique orders |

---

## Data Quality & Assumptions

* Returned transactions are excluded to reflect actual demand
* Orders are aggregated using unique invoice numbers
* Missing months are filled with `0` to maintain continuity
* Assumes consistent data capture across all periods

---

## Data Lineage

```
dw.v_sales_enriched
        ↓
Monthly Aggregation
        ↓
Continuous Time Series Construction
        ↓
data/orders_monthly.csv
        ↓
Forecasting Models / BI / Analytics
```

---

## Downstream Usage

This dataset is used in:

* 📈 Orders forecasting (Moving Average, SARIMA)
* 💰 Revenue forecasting (Orders × AOV)
* 📊 Executive KPI dashboards
* 🤖 AI-driven analytics applications

It serves as the primary input for time-series modeling pipelines.

---

## Example Use Case

This dataset enables forecasting future order volumes,
which can be translated into revenue projections and used for:

* Inventory planning
* Marketing strategy optimization
* Financial forecasting

---

## Limitations

* Limited historical data may reduce forecasting accuracy
* Monthly aggregation hides intra-month variability
* External factors (promotions, holidays) are not included

---

## 🚀 Summary

> Built a production-ready time series dataset from raw transactional data,
> enabling forecasting and data-driven decision-making.
