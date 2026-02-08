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
- All columns stored as `TEXT`
- Schema mirrors the source file
- No filtering, casting, or business logic applied

### Evidence – Raw Execution Results

**Raw table creation**
![Raw Table Creation](10_create_raw_tables.png)

**CSV load instruction and result**
![Load Raw from CSV](11_load_raw_from_csv.png)

**Raw row count verification**
![Raw Row Count Check](12_raw_rowcount_checks.png)

---

## 2. Staging Layer (20_staging)

### Purpose
- Convert raw data into an analysis-ready format
- Apply essential validation rules
- Standardize data types and formats

### Key Transformations
- Trim and normalize string fields
- Convert numeric fields using regex-based validation
- Parse `invoice_date` into timestamp
- Handle invalid or missing values
- Flag return transactions (`quantity < 0`)

### Evidence – Staging Execution Result

**Staging clean table creation and checks**
![Staging Clean Table](20_create_staging_clean.png)

---

## Why Data Foundation Matters

This layer intentionally separates data correctness from
business logic and analytics, ensuring that:

- Errors are caught early
- Downstream models remain simple and trustworthy
- Data modeling focuses on insights, not cleanup

> Clean data is not assumed — it is engineered.

---

## Downstream Dependency

All tables in the following layers depend exclusively on this foundation:

- `30_dw` (Data Warehouse)
- `40_marts` (Analytics & KPI layer)

---

## Related Documentation

- `10_raw/`  
- `20_staging/`
