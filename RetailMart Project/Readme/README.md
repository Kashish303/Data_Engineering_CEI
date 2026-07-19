# 🏪 RetailMart Lakehouse
### End-to-End Data Engineering Pipeline using Databricks, Apache Spark & Delta Lake

![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=for-the-badge&logo=databricks&logoColor=white)
![Apache Spark](https://img.shields.io/badge/Apache%20Spark-E25A1C?style=for-the-badge&logo=apachespark&logoColor=white)
![Delta Lake](https://img.shields.io/badge/Delta%20Lake-003366?style=for-the-badge)
![SQL](https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![PySpark](https://img.shields.io/badge/PySpark-FDEE21?style=for-the-badge&logo=apachespark&logoColor=black)

---

# 📌 Project Overview

RetailMart Lakehouse is an end-to-end Data Engineering project that demonstrates the implementation of the **Medallion Architecture (Bronze → Silver → Gold)** using **Databricks**, **Apache Spark**, and **Delta Lake**.

The project transforms raw retail transactional data into business-ready analytical datasets through scalable ETL pipelines while following modern Data Engineering best practices such as modular architecture, incremental processing, Delta MERGE operations, SCD Type 2 implementation, audit columns, quarantine handling, and centralized configuration management.

The final processed datasets are visualized using an interactive Executive Dashboard to support business decision-making.

---

# 🏗️ Solution Architecture

```
                    Source CSV Files
                           │
                           ▼
                Bronze Layer (Raw Ingestion)
                           │
                           ▼
        Silver Layer (Cleaning & Standardization)
                           │
                           ▼
      Gold Layer (Business Analytics & Reporting)
                           │
                           ▼
          Executive Dashboard & Business Insights
```

---

# 🎯 Project Objectives

- Build an end-to-end Lakehouse Architecture.
- Implement Medallion Architecture using Delta Lake.
- Design scalable ETL pipelines using Apache Spark.
- Improve data quality through validation and cleansing.
- Preserve historical data using SCD Type 2.
- Build business-ready analytical datasets.
- Create an Executive Dashboard for business reporting.

---

# 🛠️ Technology Stack

| Category | Technologies |
|----------|--------------|
| Platform | Databricks |
| Processing Engine | Apache Spark (PySpark) |
| Storage | Delta Lake |
| Query Language | SQL |
| Catalog | Unity Catalog |
| Dashboard | Databricks SQL Dashboard |
| Version Control | Git & GitHub |

---

# 📂 Repository Structure

```
RetailMart_Lakehouse_Project
│
├── Config
│
├── Utilities
│
├── Bronze
│
├── Silver
│
├── Gold
│
├── SQL_Queries
│
├── Outputs
│     ├── Silver
│     └── Gold
│
├── Dashboard
│
├── Documentation
│
└── README.md
```

---

# 🟤 Bronze Layer

The Bronze layer ingests raw retail data exactly as received from the source system without modifying the original records.

### Key Features

- Raw CSV Ingestion
- Delta Lake Storage
- Configuration Driven Pipeline
- Schema Validation
- Record Count Validation
- Quarantine Tables
- Audit Columns
- Exception Handling using Try-Catch

---

# ⚪ Silver Layer

The Silver layer focuses on improving data quality by performing cleaning, standardization, validation, and business transformations.

### Key Features

- Duplicate Removal
- Missing Value Handling
- Data Standardization
- Entity Separation
- Incremental Processing
- Delta MERGE
- Audit Columns
- SCD Type 2 for Product Dimension

---

# 🟡 Gold Layer

The Gold layer generates business-ready datasets optimized for reporting and analytics.

### Business Tables

- Fact Sales
- Monthly Revenue
- Customer 360
- Customer Segmentation
- Above Average Customers
- Sales Funnel Analysis
- Product Ranking
- Customer Churn Risk
- Trending Products

---

# 📊 Executive Dashboard

The interactive dashboard provides business insights including:

- Revenue KPIs
- Monthly Revenue Trend
- Revenue by Order Status
- Customer Segmentation
- Customer Churn Distribution
- Product Ranking
- Trending Products
- High Value Customers
- Top States by Revenue

---

# ⚙️ Engineering Decisions

This project was designed using production-oriented Data Engineering practices.

### ✔ Modular Project Structure

Configuration, Utilities, Bronze, Silver, Gold, Dashboard, Documentation and SQL modules were separated to improve maintainability and code reuse.

### ✔ Centralized Configuration

A dedicated configuration notebook manages catalog names, schemas, table names, storage paths, and Spark configurations.

### ✔ Reusable Utility Functions

Common helper functions are maintained in a separate utility notebook to eliminate duplicate code.

### ✔ Delta Lake

All layers are implemented using Delta Lake to leverage:

- ACID Transactions
- Schema Enforcement
- Schema Evolution
- Time Travel
- Delta MERGE
- Incremental Processing

### ✔ Quarantine Tables

Invalid records are isolated into dedicated quarantine tables instead of being discarded, improving data quality and debugging.

### ✔ Audit Columns

Audit metadata including ingestion timestamp, ingestion date, pipeline name, and run ID are maintained to improve traceability and governance.

### ✔ Exception Handling

Robust Try-Catch blocks were implemented across notebooks to improve reliability and simplify debugging.

### ✔ SCD Type 2

Historical product records are maintained using:

- Effective Date
- Expiry Date
- Current Record Flag

### ✔ Advanced SQL

The analytical layer utilizes:

- CTEs
- Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- Aggregate Functions
- CASE Expressions
- Date Functions

---

# 📈 Business Insights

The project enables business users to analyze:

- Customer Lifetime Value
- Customer Churn Risk
- Product Performance
- Revenue Trends
- Customer Segmentation
- High Value Customers
- Sales Funnel Performance
- Geographic Sales Distribution

---

# 📄 Documentation

Detailed project documentation is included covering:

- Solution Design
- Engineering Decisions
- Medallion Architecture
- Bronze Layer
- Silver Layer
- Gold Layer
- Dashboard
- Delta Lake
- Apache Spark
- Production Enhancements

---

# 🌟 Key Highlights

- End-to-End Lakehouse Implementation
- Production-Oriented ETL Pipeline
- Medallion Architecture
- Apache Spark
- Delta Lake
- Incremental Processing
- SCD Type 2
- Quarantine Tables
- Audit Columns
- Executive Dashboard
- Enterprise-Style Project Structure

---

# 👩‍💻 Author

**Kashish Soni**

B.Tech – Computer Science Engineering

Aspiring Data Engineer

GitHub: https://github.com/Kashish303

LinkedIn: https://www.linkedin.com/in/kashish-soni-087195321