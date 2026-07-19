# E-Commerce Order Analytics System

## Project Overview

An end-to-end Data Analytics project that simulates a real-world
e-commerce pipeline using **Python, Pandas, SQLite, and SQL**.

The project covers the complete lifecycle:

-   Synthetic data generation
-   Data cleaning & validation
-   SQL database design
-   Business analytics
-   Advanced SQL (Window Functions & CTEs)
-   Cohort & RFM analysis
-   Command-line reporting
-   Edge case testing

------------------------------------------------------------------------

## Folder Structure

``` text
ecommerce-analytics-system/
│── data/
│   ├── raw/
│   └── cleaned/
│
│── database/
│   └── ecommerce.db
│
│── notebooks/
│   ├── generate_data.ipynb
│   ├── clean_data.ipynb
│   ├── load_database.ipynb
│   ├── sql_analytics_basic.ipynb
│   ├── sql_analytics_advanced.ipynb
│   ├── report_cli_development.ipynb
│   └── edge_case_testing.ipynb
│
│── sql/
│   ├── schema.sql
│   ├── aggregations.sql
│   ├── window_functions.sql
│   └── cohort_analysis.sql
│
│── scripts/
│   └── report_cli.py
│
└── README.md
```

------------------------------------------------------------------------

## Technologies

-   Python
-   Pandas
-   Faker
-   SQLite
-   SQL
-   Jupyter Notebook

------------------------------------------------------------------------

## Workflow

1.  Generate synthetic datasets.
2.  Introduce intentional inconsistencies.
3.  Clean and validate data.
4.  Load cleaned data into SQLite.
5.  Execute analytical SQL queries.
6.  Perform cohort and customer segmentation analysis.
7.  Generate reports using CLI.
8.  Validate edge cases.

------------------------------------------------------------------------

## Features

### Data Generation

-   500+ records
-   Invalid emails
-   NULL customer IDs
-   Wrong date formats
-   Future dates
-   Negative quantities
-   Invalid foreign keys

### Data Cleaning

-   Missing value handling
-   Duplicate removal
-   Product normalization
-   Email validation
-   Referential integrity checks

### SQL Analytics

-   Revenue Analysis
-   Top Customers
-   Product Performance
-   Return Analysis
-   AOV
-   Window Functions
-   CTEs
-   Cohort Analysis
-   RFM Segmentation

### CLI Reports

Examples:

``` bash
python report_cli.py --report revenue

python report_cli.py --report top_customers

python report_cli.py --report retention

python report_cli.py --report monthly --start 2024-01-01 --end 2024-12-31
```

------------------------------------------------------------------------

## How to Run

1.  Execute `generate_data.ipynb`
2.  Execute `clean_data.ipynb`
3.  Execute `load_database.ipynb`
4.  Run SQL notebooks
5.  Execute:

``` bash
python report_cli.py --report revenue
```

------------------------------------------------------------------------

## Business Insights

The project enables: - Customer Lifetime Value - Revenue Trends -
Retention Analysis - Product Performance - Customer Segmentation -
Cohort Tracking

------------------------------------------------------------------------

## Future Enhancements

-   Interactive Dashboard (Power BI/Tableau)
-   PostgreSQL Support
-   Airflow Scheduling
-   Docker Deployment
-   Cloud Storage Integration

------------------------------------------------------------------------

## Author

Kashish Soni
