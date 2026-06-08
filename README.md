# Week 2 – SQL Projects 

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

cat > /mnt/user-data/outputs/Week2_README_Final.md << 'READMEEOF'
# 🛒 Week 2 — E-Commerce Sales Database Analysis using SQL

> **Celebal Excellence Internship (CEI '26) — Data Engineering Track**  
> **Intern:** Kashish Soni | SKIT Jaipur | B.Tech CSE 2022–2026  
> **Week 2 Assignment:** SQL Basics, Filtering, Aggregation, Joins & Transactions

---

## 📌 Objective

Design and query a relational database for **ShopEase** — a mid-sized Indian e-commerce company — to extract meaningful business insights about customers, products, orders, and sales performance using SQL.

The goal was not just to write correct queries, but to write queries that reflect **real-world data engineering thinking** — understanding why a constraint exists, when an index helps, and how a transaction protects business data.

---

## 🗄️ Database Schema

The database `business` consists of **4 interrelated tables** designed with proper constraints, indexes, and foreign key relationships.

```
customers  ──(1:N)──▶  orders
orders     ──(1:N)──▶  order_items
products   ──(1:N)──▶  order_items
```

| Table | Primary Key | Records Inserted |
|---|---|---|
| customers | customer_id | 8 |
| products | product_id | 8 |
| orders | order_id | 10 |
| order_items | item_id | 15 |

### Foreign Key Relationships

| Child Table | Foreign Key | References | Purpose |
|---|---|---|---|
| orders | customer_id | customers(customer_id) | Every order must belong to a real customer |
| order_items | order_id | orders(order_id) | Every item must belong to a real order |
| order_items | product_id | products(product_id) | Every item must reference a real product |

---

# What Was Done — Section by Section

---

### 📘 Section A — SQL Basics

This section covered data retrieval, schema understanding, and constraint behavior. Rather than simply writing SELECT queries, each constraint was **practically tested** by running actual INSERT statements that violate the rules — and the real MySQL error codes were captured and documented inside the SQL file.

For Q6, an important observation was noted: the schema uses `CHECK (unit_price > 0)` — strictly greater than zero, not greater than or equal to zero. This was intentional — a product priced at ₹0 would appear as free to customers and corrupt all revenue calculations. Understanding **why** a constraint is designed a certain way shows deeper schema awareness than just knowing what it does.

**Questions Covered:** SELECT *, column selection, DISTINCT, Primary Key explanation, UNIQUE + NOT NULL constraint testing, CHECK constraint violation.

---

### 📗 Section B — Filtering & Optimization

This section went beyond basic WHERE clauses into **query performance** and **index behavior** — topics that matter enormously in production data engineering.

The most significant concept explored here was **SARGable query writing**. When MySQL encounters `YEAR(join_date) = 2024`, it cannot use the index on `join_date` because the function wraps the column — forcing a Full Table Scan across every row. The fix is to rewrite the condition as a date range:

```sql
WHERE join_date >= '2024-01-01'
AND join_date < '2025-01-01'
```

This keeps the column untouched on one side of the comparison, allowing the B-Tree index to jump directly to matching records — reducing complexity from **O(n)** to **O(log n)**. The difference was verified using MySQL's `EXPLAIN` command, which clearly showed `type: ALL` (full scan) for the bad query and `type: range` (index used) for the rewritten version.

This same SARGable principle was proactively applied in Q9 as well — before the question even asked for it — demonstrating that the concept was genuinely understood, not just answered in isolation.

**Questions Covered:** Basic filtering, multi-condition WHERE, date range filtering, BETWEEN, index explanation with EXPLAIN proof, SARGable rewrite.

---

### 📙 Section C — Aggregation

This section covered GROUP BY, aggregate functions, and the critical difference between WHERE and HAVING. Every aggregation query was written with meaningful aliases and ORDER BY clauses to make results readable as actual business reports.

Two bonus observations were added that were not required by the questions:

In Q16, it was noted that Shipped orders have a **higher average order value (₹6,798)** than Delivered orders (₹2,865). This means the highest-value orders are still in transit — a meaningful business monitoring signal that would normally come from a data analyst's report, not a SQL exercise.

In Q17, a `price_range` column was added (`MAX - MIN`) to show how wide the pricing spread is within each category. Clothing has the highest variation at ₹3,800 — meaning it serves both budget and premium customers, making it the most diverse category in the catalog.

In Q13, two methods were shown for counting orders — `COUNT(*)` and `COUNT(order_id)` — with an explanation of when each is appropriate and why the Primary Key approach guarantees uniqueness.

**Questions Covered:** COUNT, SUM, AVG, GROUP BY, ORDER BY, MAX/MIN, HAVING vs WHERE.

---

### 📕 Section D — Joins & Relationships

Joins are the most critical SQL skill for data engineering, and this section was treated accordingly. Every join query was written with table aliases, and the reasoning behind each join type was documented clearly.

For Q20, a CASE statement was embedded inside the LEFT JOIN query to label each customer as `Premium` or `Regular` based on the `is_premium` column. This was not required — but it transformed a basic join result into a **customer segmentation report**.

For Q21, the question asked for a 3-table join. A second version was written that joins all **4 tables** and calculates three additional business metrics:

- `gross_amount` — total before discount
- `net_amount` — actual amount paid after discount  
- `discount_saved` — how much each customer saved

This mirrors the structure of a real e-commerce revenue report used in data pipelines — the kind of query that feeds a Power BI dashboard or a Databricks notebook.

For Q22, an important MySQL limitation was addressed and solved: **MySQL does not support FULL OUTER JOIN natively**. It was simulated using `LEFT JOIN UNION RIGHT JOIN` — a standard workaround used in production environments.

For Q23, the Foreign Key violation was not just explained — it was actually triggered by running an INSERT with `customer_id = 999`, and the real MySQL Error Code 1452 was captured and included. This proves the constraint was tested, not just described.

**Questions Covered:** INNER JOIN, LEFT JOIN with CASE, 3-table + 4-table JOIN, LEFT vs RIGHT vs FULL OUTER JOIN simulation with UNION, Foreign Key violation demonstration.

---

### 📓 Section E — Advanced Concepts

This section covered conditional logic, ACID properties, and transaction management — the most conceptually demanding part of the assignment.

For Q25, beyond the required delivered vs not-delivered count, a `delivery_success_rate` column was calculated and formatted as a percentage. This is a real **business KPI** — the kind of metric tracked in operations dashboards — calculated directly inside SQL without any post-processing.

For Q26, instead of using the generic bank transfer example that the question suggested, the ACID properties were explained using **ShopEase's own tables and constraints**. Each property was tied to a scenario involving orders, stock, and payments within this exact schema — showing that the concepts were understood in context, not memorized in isolation. MySQL's default isolation level (**REPEATABLE READ**) was also mentioned, which prevents dirty reads and phantom reads in concurrent transactions.

For Q27, two complete transaction blocks were written:

The first demonstrates a **successful transaction** — inserting a new order, two order items, and updating stock quantities for both products, ending with COMMIT. Before committing, a SELECT was included to verify stock changes were correct.

The second demonstrates a **deliberate failure** — an order item is inserted with `product_id = 999` which does not exist, triggering a Foreign Key violation and causing the entire transaction to ROLLBACK. A SELECT after the ROLLBACK confirms that no partial data remains — proving that atomicity worked correctly.

A note was also included explaining why ROLLBACK cannot be used inside Functions — only inside Procedures. Functions are deterministic calculators designed to return a value without side effects. Procedures are action performers designed to modify the database. This distinction is commonly misunderstood and was proactively documented.

**Questions Covered:** CASE for price tiers, CASE inside SUM for conditional aggregation, ACID with ShopEase-specific examples, complete COMMIT + ROLLBACK transaction blocks.

---

## 💡 Key Technical Highlights

**SARGable query writing** was applied proactively across two questions — not just where asked — by consistently using date ranges instead of functions on indexed columns. This demonstrates awareness of how query patterns affect execution plans in large datasets.

**FULL OUTER JOIN simulation** using `LEFT JOIN UNION RIGHT JOIN` addresses a real MySQL limitation that most beginners are unaware of. This pattern is used in production data reconciliation pipelines.

**Conditional aggregation** using `CASE` inside `SUM` is a standard technique in data engineering for building pivot-style reports within a single SQL query — far more efficient than running multiple subqueries.

**Both COMMIT and ROLLBACK were demonstrated practically** — not just written theoretically. The ROLLBACK example was deliberately triggered using a Foreign Key violation, and the result was verified with a SELECT to confirm no partial data was stored.

**Real MySQL error codes were captured throughout** — Error 1062 for duplicate email, Error 3819 for CHECK constraint violation, Error 1452 for Foreign Key violation. Every rule was tested, not just described.

---

# 📊 Project 2: Superstore Sales Analysis using SQL
📌 Objective

Analyze retail sales data using SQL and transform raw transactional records into meaningful business insights.

The goal of this project was not only to write SQL queries, but also to understand how businesses use data to evaluate performance, identify growth opportunities, monitor profitability, and support decision-making.

The project follows a complete analytics workflow beginning with data exploration, followed by filtering, aggregation, ranking analysis, business use cases, and final data validation.

🔍 Step 1 — Data Loading

The Superstore dataset was imported into a SQL database and stored inside the superstore_sales table.

Before beginning any analysis, the dataset was verified to ensure that all records and columns were imported successfully.

This step is critical because any issue during data ingestion can affect all downstream analysis.

📗 Step 2 — Data Exploration

This section focused on understanding the structure, quality, and contents of the dataset before performing any business analysis.

The following activities were performed:

Sample Record Inspection
Row Count Validation
Column Identification
Region Exploration
Category Exploration
Date Range Analysis
NULL Value Audit
⭐ Notable Implementation — NULL Audit

Before generating any insights, a dedicated NULL value audit was performed on critical business columns such as:

Order ID
Order Date
Customer ID
Product ID
Sales
Profit

This step helps ensure that aggregations and business reports are based on complete and reliable data.

In real-world analytics projects, data quality verification is often performed before any reporting or dashboard development begins.

⭐ Notable Implementation — Date Range Analysis

The earliest and latest order dates were identified to understand the time span covered by the dataset.

This provides context for trend analysis and ensures that future comparisons are performed within the correct time period.

📘 Step 3 — Filtering Analysis

This section focused on extracting meaningful subsets of data using the WHERE clause.

Instead of analyzing the entire dataset at once, business-focused filters were applied to isolate specific transactions, customer groups, and product categories.

Questions Covered
Region-wise Analysis
Category-wise Analysis
High-Value Transactions
Loss-Making Orders
Discount-Based Analysis
Combined Business Filters
⭐ Notable Implementation — High Sales but Negative Profit Investigation

A dedicated query was written to identify transactions generating strong revenue but negative profit.

This analysis highlights an important business reality:

High sales do not always translate into high profitability.

Such transactions often indicate:

Excessive discounting
High shipping costs
Pricing inefficiencies
Operational losses

This type of analysis is commonly performed by business analysts to identify revenue leakage and profitability issues.

⭐ Notable Implementation — Heavy Discount Analysis

Transactions with discounts greater than 30% were isolated and analyzed separately.

This helps evaluate whether aggressive discounting strategies are driving sustainable business growth or simply reducing profit margins.

⭐ Business Insight

Filtering enables organizations to focus on specific areas of interest rather than analyzing the entire dataset.

Examples include:

Investigating underperforming regions
Monitoring high-value customers
Evaluating discount effectiveness
Identifying loss-making transactions
📙 Step 4 — Aggregation & Reporting

This section focused on transforming thousands of transactional records into meaningful business metrics using GROUP BY and aggregate functions.

The following functions were extensively used:

SUM()
AVG()
COUNT()
ROUND()
GROUP BY
HAVING
Questions Covered
Regional Performance Analysis
Category Performance Analysis
Sub-Category Profitability
Customer Segment Analysis
HAVING Clause
⭐ Notable Implementation — Profitability Classification using CASE

Instead of displaying only numerical profit values, a CASE statement was used to classify business performance into categories:

LOSS-MAKING
LOW MARGIN
HEALTHY
STAR

This converts raw numerical data into business-friendly performance indicators that are easier for stakeholders to understand.

⭐ Notable Implementation — Revenue vs Profit Analysis

The analysis demonstrated that categories generating high revenue do not necessarily generate high profits.

This highlights the importance of evaluating:

Revenue
Profit
Profit Margin

together rather than relying on a single metric.

⭐ Notable Implementation — Customer Segment Analysis

Customer segments were compared using:

Total Customers
Total Orders
Total Revenue
Average Order Value
Profit Margin

This helps organizations identify which customer groups generate the highest value and deserve greater marketing focus.

⭐ HAVING Clause Demonstration

The HAVING clause was used to filter aggregated results after grouping.

This demonstrated the difference between:

WHERE

which filters rows before aggregation,

and

HAVING

which filters groups after aggregation.

📕 Step 5 — Ranking Analysis

This section focused on identifying the most important contributors to business performance using ORDER BY and LIMIT.

Questions Covered
Top Customers by Revenue
Top Products by Sales
Bottom Products by Profit
Top States by Revenue
⭐ Notable Implementation — Customer Revenue Ranking

Customers were ranked based on:

Revenue Generated
Order Frequency
Profit Contribution

This helps identify high-value customers who contribute significantly to business growth.

⭐ Notable Implementation — Product Performance Analysis

Products were evaluated using:

Sales
Quantity Sold
Profit

This provides a more complete view of product performance than sales alone.

⭐ Business Insight

Revenue alone cannot determine success.

A product may generate strong sales while simultaneously reducing profitability.

Therefore, revenue, profit, and profit margin should always be analyzed together.

📓 Step 6 — Business Use Cases

This section moved beyond standard SQL exercises and focused on solving practical business problems.

Questions Covered
Monthly Sales Trend Analysis
Customer Retention Analysis
Duplicate Order Investigation
⭐ Notable Implementation — Monthly Sales Trend Analysis

Sales and profit were analyzed month-by-month to identify:

Growth Patterns
Seasonal Trends
Revenue Fluctuations

Trend analysis helps organizations forecast future performance and plan inventory, marketing, and operational strategies.

⭐ Notable Implementation — Customer Retention Classification

Customers were segmented into:

One-Time Buyers
Occasional Buyers
Loyal Customers

based on purchasing frequency.

This mirrors customer retention analysis commonly performed in CRM and marketing systems.

⭐ Notable Implementation — Duplicate Investigation

Order IDs appearing multiple times were analyzed to determine whether they represented:

True Duplicate Records
Legitimate Multi-Product Orders

This demonstrates the importance of understanding business context before treating repeated records as data-quality issues.

⭐ Business Insight

Customer retention is often more profitable than customer acquisition.

Loyal customers typically generate higher lifetime value and contribute significantly to long-term revenue.

📒 Step 7 — Data Validation & Quality Checks

Before generating final conclusions, dedicated validation checks were performed.

Validation Activities
Dataset Summary Verification
Missing Value Detection
Invalid Data Detection
Revenue Validation
Consistency Checks
⭐ Notable Implementation — Impossible Value Detection

Special validation rules were written to identify records that violate expected business logic.

Examples checked:

Negative Sales
Zero Quantity
Discounts Greater Than 100%

Such records may indicate:

Data Entry Errors
ETL Issues
Data Quality Problems
⭐ Notable Implementation — Dataset Summary Validation

A high-level dataset summary was generated including:

Total Revenue
Total Profit
Total Units Sold
Unique Orders
Unique Customers
Unique Products

This acts as a final validation step before reporting.

⭐ Business Insight

Data validation is one of the most important stages of analytics.

Business decisions should only be made after confirming that the underlying data is complete, consistent, and reliable.

🚀 Beyond Assignment Requirements

Several additional analyses were performed beyond the assignment requirements:

Customer Retention Classification

Customers were segmented into loyalty categories based on purchasing frequency.

Product Profitability Classification

Products were categorized as:

LOSS-MAKING
LOW MARGIN
HEALTHY
STAR

using CASE statements.

High Sales vs Low Profit Investigation

A dedicated analysis was performed to identify products generating revenue but failing to generate profit.

Revenue Contribution Analysis

Different business segments were compared based on their contribution to overall revenue.

Data Quality Auditing

Additional validation checks were performed to improve confidence in analytical results.

💡 Key Learnings

Through this project I gained practical experience in:

SQL Query Writing
Data Exploration
Business-Oriented Filtering
Aggregation & Reporting
Customer Analytics
Profitability Analysis
Trend Analysis
Data Validation
Business Intelligence Reporting

Most importantly, this project helped b

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
