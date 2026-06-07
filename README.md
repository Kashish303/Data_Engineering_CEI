# Week 2 – SQL Projects Portfolio

## Overview

This repository contains two SQL-based projects completed as part of my Data Engineering and Analytics learning journey. The focus of these projects was not only to learn SQL syntax but also to understand how databases are used to solve real-world business problems.

The projects cover database design, data integrity, query optimization, transaction management, sales analytics, customer behavior analysis, profitability analysis, and data quality validation.

Through these projects, I applied SQL to both operational and analytical use cases, simulating scenarios commonly encountered in e-commerce platforms and business intelligence environments.

---

# Project 1: ShopEase E-Commerce Database Analysis

## Objective

Design and analyze a relational e-commerce database while applying core database concepts such as constraints, indexing, joins, transactions, and ACID properties.

## Key Areas Covered

### Database Design & Relationships

* Primary Keys
* Foreign Keys
* Referential Integrity
* Relational Schema Design

### SQL Querying

* Data Retrieval
* Filtering & Sorting
* Aggregate Functions
* Conditional Logic using CASE

### Joins & Relationships

* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL OUTER JOIN (Simulated using UNION)

### Database Optimization

* Indexing
* Query Performance Analysis
* EXPLAIN Plans

### Transactions & Reliability

* START TRANSACTION
* COMMIT
* ROLLBACK
* ACID Properties

## Additional Enhancements

To go beyond the assignment requirements, additional business-oriented analysis was performed:

* Customer Segmentation using CASE
* Revenue & Discount Analytics
* Delivery Success Rate KPI
* Constraint Validation through Error Testing
* Query Optimization Awareness
* Real-world ACID Examples using E-Commerce Scenarios

## Skills Demonstrated

* Relational Database Design
* SQL Query Writing
* Data Integrity Management
* Query Optimization
* Transaction Handling
* Business-Oriented Data Analysis

---

# Project 2: Superstore Sales Analysis using SQL

## Objective

Analyze retail sales data using SQL and transform raw transactional records into actionable business insights.

## Key Areas Covered

### Data Exploration

* Schema Analysis
* Row Count Validation
* Date Range Analysis
* NULL Value Audit

### Filtering Analysis

* Region-wise Analysis
* Category-wise Analysis
* High-Value Transactions
* Discount Analysis
* Loss-Making Orders

### Aggregation & Reporting

* Regional Performance
* Category Performance
* Sub-Category Profitability
* Customer Segment Analysis
* Profit Margin Analysis

### Ranking Analysis

* Top Customers by Revenue
* Top Products by Sales
* Least Profitable Products
* Top Performing States

### Business Use Cases

* Monthly Sales Trends
* Customer Retention Analysis
* Duplicate Order Investigation

### Data Validation

* Missing Value Detection
* Impossible Value Checks
* Duplicate Record Validation
* Dataset Summary Verification

## Additional Enhancements

Beyond the assignment requirements, the project includes:

* Customer Retention Classification
* Product Profitability Classification
* High Sales vs Low Profit Analysis
* Revenue Contribution Analysis
* Data Quality Auditing
* Business Insight Generation

## Skills Demonstrated

* SQL Analytics
* Business Intelligence Reporting
* Data Validation
* Customer Behavior Analysis
* Profitability Analysis
* Trend Analysis

---

# SQL Concepts Practiced Across Both Projects

* SELECT
* WHERE
* DISTINCT
* ORDER BY
* LIMIT
* GROUP BY
* HAVING
* CASE
* Aggregate Functions
* Date Functions
* Joins
* Constraints
* Indexing
* Transactions
* ACID Properties
* Data Validation Queries

---

# Key Learnings

These projects helped me understand how SQL is used beyond simple querying and how databases support both operational systems and analytical decision-making.

Major learnings include:

* Designing and managing relational databases
* Maintaining data integrity using constraints
* Optimizing query performance with indexes
* Generating business insights from transactional data
* Performing customer and sales analytics
* Validating data quality before analysis
* Applying SQL to solve practical business problems

---

## Tools & Technologies

* MySQL Workbench
* SQL
* SQLite
* Superstore Sales Dataset
* Relational Database Concepts

---

## Conclusion

Week 2 focused on building strong SQL foundations through both database management and business analytics projects.

The ShopEase project emphasized database design, integrity, and transaction management, while the Superstore project focused on analytical reporting, customer insights, profitability analysis, and data validation.

Together, these projects demonstrate practical SQL skills that are directly applicable to Data Engineering, Data Analytics, and Business Intelligence workflows.

**Author:** Kashish Soni



# Week 1 - Product Data Exploration and Cleaning using Pandas

## Objective

The objective of this assignment was to learn Python fundamentals and perform data exploration, cleaning, transformation, and feature engineering using the Pandas library on a real-world e-commerce dataset.

---

## Technologies used
- Python
- Pandas
- Jupyter Notebook

## Dataset Overview

The dataset contains 1000 Myntra product records with 24 attributes, including:

* Product Information
* Ratings and Reviews
* Pricing Details
* Seller Information
* Product Specifications
* Offers and Discounts
* Product Variations

Several columns contained nested JSON-like structures stored as strings, making the dataset more complex than a standard tabular dataset.

Examples:

* product_specifications
* amount_of_stars
* breadcrumbs
* sizes
* more_offers
* delivery_options

---

## Tasks Performed

### 1. Data Loading

* Loaded the CSV dataset into a Pandas DataFrame.
* Verified successful ingestion of all records.

---

### 2. Data Exploration

Performed initial exploratory analysis using:

* `head()`
* `tail()`
* `shape`
* `columns`
* `dtypes`

### Key Findings

* Total Records: **1000**
* Total Columns: **24**
* Dataset contains both structured and semi-structured information.

---

### 3. Missing Value Analysis and Handling

Identified missing values using:

```python
df.isnull().sum()
```

| Column              | Missing | Action         | Reason                                     |
| ------------------- | ------- | -------------- | ------------------------------------------ |
| discount            | 121     | Filled with 0  | No discount = 0%, not average              |
| what_customers_said | 573     | Filled with [] | Maintains JSON structure                   |
| seller_name         | 301     | Unknown Seller | Mode would create false seller attribution |
| videos              | 781     | Filled with [] | No video represented as empty list         |
| seller_information  | 301     | Not Available  | Human-readable placeholder                 |
| variations          | 562     | Filled with [] | Maintains list structure                   |

Domain-based imputation was used instead of blindly applying mean, median, or mode. The handling strategy was selected based on the meaning and structure of each column.

---

### 4. Basic Data Operations

Performed:

* Column Selection
* Row Filtering
* Multi-condition Filtering

Examples:

* Products with discounts greater than 50%
* Products containing customer reviews
* Products containing videos
* Products satisfying multiple filtering conditions

These operations helped in understanding and manipulating the dataset effectively using Pandas.

---

### 5. Duplicate Analysis

Checked:

* Full Row Duplicates
* Duplicate Product IDs

Using:

```python
df.duplicated().sum()
```

and

```python
df['product_id'].duplicated().sum()
```

The process for identifying and handling duplicate records was also explored.

---

### 6. Derived Columns Creation

Created new derived columns for analysis.

#### Quantity Column

The dataset did not contain an explicit quantity field. A quantity column was created for further calculations.

```python
df['quantity'] = 1
```

#### Total Amount Column

A new derived column was created using:

```text
total_amount = final_price × quantity
```

Before calculation, the price values were cleaned and converted into numeric format.

---

### 7. Data Export

The cleaned dataset was exported as:

```text
cleaned_myntra_dataset.csv
```

using:

```python
df.to_csv('cleaned_myntra_dataset.csv', index=False)
```

---

## 💡 Key Insight

The `final_price` column contained currency-formatted strings such as:

```text
"₹3,995.00"
```

These values could not be used directly for numerical calculations.

Custom string cleaning was performed using Pandas string operations (`str.replace()`) to remove currency symbols, commas, and quotation marks before converting the values to floating-point numbers.

Example:

```text
"₹3,995.00" → 3995.00
```

This represents a common real-world data quality challenge where business data must be transformed from presentation format into analysis-ready numerical format.

---
## Outcome

Successfully transformed a raw e-commerce dataset into a cleaned and analysis-ready dataset using Python and Pandas. The dataset was explored, cleaned, validated, enriched with derived features, and exported for future analysis.
