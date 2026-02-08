# Data Foundation

## Overview
The Data Foundation layer is responsible for ingesting, standardizing,
and validating source data before any analytical modeling occurs.

This layer ensures data reliability, reproducibility, and auditability,
forming a trusted base for downstream data modeling and analytics.

---

## Architecture Scope

10_raw     → Source-aligned raw ingestion  
20_staging → Standardization and data quality enforcement

---

## 1. Raw Layer (10_raw)

### Purpose
- Preserve source data with zero transformation
- Enable reprocessing and traceability
- Avoid premature assumptions about data quality

### Design Principles
- All columns stored as TEXT
- Schema mirrors the source file
- No filtering, casting, or business logic applied

### Example Table
- raw.online_retail

### Validation
- Row count verification after ingestion
- Structural sanity checks only

---

## 2. Staging Layer (20_staging)

### Purpose
- Convert raw data into an analysis-ready format
- Apply minimal but essential validation rules
- Standardize data types and formats

### Key Transformations
- Trim and normalize string fields
- Convert numeric columns using regex-based validation
- Parse invoice_date into timestamp
- Handle invalid or missing values explicitly
- Flag return transactions (quantity < 0)

### Example Table
- staging.online_retail_clean

### Data Quality Checks
- NULL checks on business-critical fields
- Minimum and maximum date validation
- Post-transformation row count sanity checks

---

## Why Data Foundation Matters

This layer intentionally separates data correctness from
business logic and analytics, ensuring that:

- Errors are caught early
- Downstream models remain simple and trustworthy
- Data modeling focuses on insights, not cleanup

Clean data is not assumed — it is engineered.

---

## Downstream Dependency

All tables in the following layers depend exclusively on this Data Foundation:

- 30_dw (Data Warehouse)
- 40_marts (Analytics and KPI layer)

---

### Raw Layer Validation

The following results confirm that the source data
was ingested into the raw layer without transformation or data loss.

**Raw table creation**
![Create Raw Tables](result/10_create_raw_tables.png)

**CSV load execution**
![Load Raw from CSV](result/11_load_raw_from_csv.png)

**Row count verification**
![Raw Row Count Check](result/12_raw_rowcount_checks.png)

---

### Staging Layer – Data Quality Checks

After standardization, core data quality checks were performed
to validate critical fields, data types, and date ranges.

**Staging clean table creation and sanity checks**
![Staging Clean Table](result/20_create_staging_clean.png)


---

### Portfolio Note
This project explicitly separates Data Foundation from Data Modeling,
following modern analytics engineering best practices.
