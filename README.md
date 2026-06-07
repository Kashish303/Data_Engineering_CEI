# Week 2 – SQL Projects Portfolio

## Overview

This repository contains two SQL-based projects completed as part of my Data Engineering and Analytics learning journey. The primary objective of these projects was not only to learn SQL syntax but also to understand how databases support real-world business operations and decision-making.

The projects cover database design, data integrity, constraints, indexing, query optimization, transaction management, sales analytics, customer behavior analysis, profitability analysis, and data quality validation.

Through these projects, SQL was applied to both operational and analytical use cases, simulating scenarios commonly encountered in e-commerce platforms, reporting systems, and business intelligence workflows.

---

# ⭐ Week 2 Highlights

Unlike traditional SQL assignments that focus only on writing queries, these projects emphasize practical problem-solving, business understanding, and database engineering concepts.

### Key Highlights

#### Business-Oriented SQL Analysis

Most queries were designed around real business questions rather than simple data retrieval.

Examples include:

- Customer Segmentation
- Revenue Analysis
- Profitability Analysis
- Customer Retention Analysis
- Delivery Performance Tracking
- Product Performance Evaluation

#### Constraint Validation Through Testing

Database constraints were not only studied but also intentionally tested by attempting invalid operations.

Examples tested:

- Duplicate Email Violations
- Foreign Key Violations
- CHECK Constraint Violations

This helped verify how databases enforce data integrity and prevent invalid data entry.

#### Real-World ACID Property Explanations

Instead of using generic banking examples, ACID properties were explained using practical e-commerce scenarios such as:

- Order Placement
- Inventory Updates
- Stock Management
- Concurrent Purchases

making the concepts more relevant and easier to understand.

#### Advanced SQL Usage

The projects include practical implementations of:

- CASE Statements
- Conditional Aggregation
- HAVING Clause
- Multi-Table Joins
- Indexing
- Transactions
- Data Validation Queries

#### Data Quality Awareness

Dedicated validation checks were performed before generating insights.

These checks included:

- Missing Value Analysis
- Duplicate Detection
- Invalid Data Detection
- Dataset Validation

This reflects real-world analytics workflows where data quality must be verified before making business decisions.

#### Beyond Assignment Requirements

Several additional analyses were performed beyond the questions provided:

- Customer Retention Classification
- Product Profitability Classification
- Revenue Contribution Analysis
- Delivery Success Rate KPI
- High Sales vs Low Profit Investigation
- Data Quality Auditing

These enhancements were added to demonstrate analytical thinking and practical SQL problem-solving.

---

# 🛒 Project 1: ShopEase E-Commerce Database Analysis

## Objective

The objective of this project was to design and analyze a relational e-commerce database while applying core database concepts such as constraints, indexing, joins, transactions, and ACID properties.

Rather than focusing only on query writing, the project was aimed at understanding how databases support customer management, inventory tracking, order processing, reporting, and business operations.

---

## Database Schema

The database consists of four interconnected tables:

### Customers

Stores customer information such as:

- Customer ID
- First Name
- Last Name
- Email
- City
- State
- Join Date
- Premium Membership Status

### Products

Stores product catalog information including:

- Product ID
- Product Name
- Category
- Brand
- Unit Price
- Stock Quantity

### Orders

Stores order-level transaction information including:

- Order ID
- Customer ID
- Order Date
- Order Status
- Total Amount

### Order Items

Stores product-level information for each order including:

- Item ID
- Order ID
- Product ID
- Quantity
- Unit Price
- Discount Percentage

The schema was designed using Primary Keys and Foreign Keys to maintain relationships and ensure referential integrity across the database.

---

## SQL Concepts Implemented

### Data Retrieval & Filtering

Various SQL queries were written to retrieve, filter, and analyze data.

Techniques used:

- SELECT
- DISTINCT
- WHERE
- ORDER BY
- BETWEEN
- Logical Operators

These queries helped answer business questions related to customers, products, and orders.

---

### Database Constraints

Different constraints were explored and validated, including:

#### Primary Key

Ensures that every record has a unique identifier.

#### Foreign Key

Maintains relationships between tables and prevents orphan records.

#### UNIQUE Constraint

Prevents duplicate values such as customer email addresses.

#### NOT NULL Constraint

Ensures mandatory fields always contain values.

#### CHECK Constraint

Validates business rules such as positive product pricing and stock values.

Constraint violations were intentionally tested to observe how the database protects data integrity.

---

### Joins & Relationships

Multiple JOIN operations were implemented to combine data stored across different tables.

Examples included:

- Displaying customer details along with their orders.
- Listing all customers including those without orders.
- Retrieving product-level details for every order.
- Combining customer, order, and product information into a single report.

This demonstrated how relational databases connect data across multiple entities.

---

### Query Optimization

Indexes were studied and implemented to improve query performance.

The EXPLAIN statement was used to analyze query execution plans and understand how MySQL processes data retrieval operations.

This introduced practical concepts such as:

- Full Table Scans
- Index Lookups
- Query Cost Reduction
- SARGable Query Design

---

### Conditional Logic

CASE statements were used to generate business-oriented classifications.

Examples included:

- Premium vs Regular Customers
- Product Price Classification
- Business Reporting Categories

This helped transform raw data into meaningful business information.

---

### Aggregation & Reporting

Aggregate functions were used to generate business insights.

Functions used:

- COUNT()
- SUM()
- AVG()
- GROUP BY
- Conditional Aggregation

These queries helped analyze customer activity, sales performance, and operational KPIs.

---

### Transactions & ACID Properties

Transaction management was implemented using:

```sql
START TRANSACTION;
COMMIT;
ROLLBACK;

A complete order-processing workflow was simulated where:

New orders were created.
Order items were inserted.
Inventory levels were updated.

ROLLBACK scenarios were also tested to ensure database consistency when errors occur.

ACID properties were explained using real-world e-commerce examples such as inventory updates, concurrent purchases, and order placement.

Additional Enhancements

To go beyond the assignment requirements, additional business-focused analysis was performed:

Customer Segmentation

Customers were classified as:

Premium Customers
Regular Customers

using CASE statements.

Revenue & Discount Analytics

Additional metrics were calculated:

Gross Revenue
Net Revenue
Discount Saved
Delivery Success Rate KPI

An additional KPI was calculated to measure operational efficiency and order fulfillment performance.

Constraint Validation Through Error Testing

Multiple constraint violations were intentionally tested to observe database behavior and error handling.

Skills Demonstrated
Relational Database Design
SQL Query Writing
Data Integrity Management
Query Optimization
Transaction Handling
Database Reliability Concepts
Business-Oriented Data Analysis
📊 Project 2: Superstore Sales Analysis using SQL
Objective

The objective of this project was to analyze a retail sales dataset using SQL and transform raw transactional data into actionable business insights.

The project was designed to simulate a real-world business analytics workflow covering sales performance, customer behavior, profitability analysis, customer retention, and data quality validation.

Analysis Workflow
1. Data Exploration

The dataset was first explored to understand its structure, quality, and completeness.

Activities performed:

Schema Analysis
Sample Record Inspection
Row Count Validation
Date Range Analysis
Region Identification
NULL Value Audit

This step ensured the dataset was suitable for analysis before generating insights.

2. Filtering Analysis

Business-oriented filtering was performed using WHERE clauses.

Analysis included:

Region-wise Analysis
Category-wise Analysis
Date Range Analysis
High-Value Transactions
Discount-Based Analysis
Loss-Making Orders
Combined Business Filters

These queries helped identify meaningful subsets of data and uncover hidden business patterns.

3. Aggregation & Reporting

GROUP BY and aggregate functions were used to summarize transactional data into meaningful business metrics.

Analysis included:

Regional Performance
Category Performance
Sub-Category Profitability
Customer Segment Analysis
Revenue Contribution Analysis
Profit Margin Calculations

This transformed thousands of individual transactions into easy-to-understand business reports.

4. Profitability Classification

CASE statements were used to classify business performance into categories such as:

Loss-Making
Low Margin
Healthy
Star Performer

This helped identify which business units were creating value and which required improvement.

5. Ranking Analysis

ORDER BY and LIMIT were used to identify top and bottom performers.

Analysis included:

Top Customers by Revenue
Top Products by Sales
Most Profitable Products
Least Profitable Products
Top Performing States

This helped identify key revenue drivers within the business.

6. Business Use Cases

Several practical business scenarios were implemented.

Monthly Sales Trend Analysis

Sales and profit were analyzed over time to identify growth patterns and seasonal trends.

Customer Retention Analysis

Customers were classified as:

One-Time Buyers
Occasional Buyers
Loyal Customers

to evaluate customer loyalty and long-term revenue contribution.

Duplicate Order Investigation

Repeated order IDs were analyzed to determine whether they represented true duplicates or legitimate multi-product transactions.

This demonstrated the importance of understanding business context before making assumptions about data quality.

7. Data Validation & Quality Checks

Before generating final insights, dedicated validation checks were performed.

These included:

Missing Value Detection
Duplicate Record Analysis
Invalid Data Checks
Dataset Consistency Verification
Revenue Validation

This ensured that business conclusions were based on reliable and accurate data.

Additional Enhancements

To make the project more comprehensive and business-focused, several additional analyses were performed beyond the assignment requirements.

Customer Retention Classification

Customers were segmented based on purchase frequency to identify loyal and high-value customers.

Product Profitability Classification

Products and categories were evaluated based on revenue and profit margins.

High Sales vs Low Profit Investigation

Transactions generating strong revenue but weak profitability were identified and analyzed.

Revenue Contribution Analysis

Different business segments were compared based on their contribution to total revenue.

Data Quality Auditing

Additional validation checks were performed to improve confidence in analytical results.

Skills Demonstrated
SQL Analytics
Business Intelligence Reporting
Data Validation
Customer Behavior Analysis
Profitability Analysis
Trend Analysis
Business Insight Generation
SQL Concepts Practiced Across Both Projects
Data Retrieval & Filtering
SELECT
WHERE
DISTINCT
ORDER BY
LIMIT
Aggregation & Reporting
GROUP BY
HAVING
Aggregate Functions
Conditional Logic
CASE Statements
Conditional Aggregation
Database Relationships
INNER JOIN
LEFT JOIN
RIGHT JOIN
FULL OUTER JOIN Simulation
Database Design & Optimization
Primary Keys
Foreign Keys
Constraints
Indexing
Query Optimization
EXPLAIN
Transactions & Reliability
START TRANSACTION
COMMIT
ROLLBACK
ACID Properties
Data Validation
Missing Value Checks
Duplicate Detection
Data Quality Audits
Key Learnings

These projects helped me understand how SQL is used beyond simple querying and how databases support both operational systems and analytical decision-making.

Major learnings include:

Designing and managing relational databases
Maintaining data integrity using constraints
Optimizing query performance using indexes
Generating business insights from transactional data
Performing customer and sales analytics
Validating data quality before analysis
Applying SQL to solve practical business problems
Understanding how database systems support business operations
Tools & Technologies
MySQL Workbench
SQL
SQLite
Superstore Sales Dataset
Relational Database Concepts
Conclusion

Week 2 focused on building strong SQL foundations through both database management and business analytics projects.

The ShopEase project emphasized database design, integrity, constraints, indexing, joins, and transaction management, while the Superstore project focused on analytical reporting, customer insights, profitability analysis, trend analysis, and data validation.

Together, these projects demonstrate practical SQL skills that are directly applicable to Data Engineering, Data Analytics, Database Administration, and Business Intelligence workflows.




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
