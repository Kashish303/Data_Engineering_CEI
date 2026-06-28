<img width="1600" height="900" alt="Image5" src="https://github.com/user-attachments/assets/b9340691-0fc3-4260-ba3f-35306102dc47" />
<img width="1600" height="900" alt="Image4" src="https://github.com/user-attachments/assets/e16eb7ae-fe52-4f78-a798-405023a54ed7" />
<img width="1600" height="900" alt="Image3" src="https://github.com/user-attachments/assets/725b2f1b-e467-410b-9cd7-aa93d63dce2e" />
<img width="1600" height="900" alt="Image2" src="https://github.com/user-attachments/assets/80922eaa-a569-42b7-bd67-5089e2f8adfc" />
<img width="1600" height="900" alt="Image1" src="https://github.com/user-attachments/assets/cc291af3-4b42-400e-89f3-71535bea9432" />

# ☁️ Week 5 - Spark Basics 

# 📌 Project Overview

This project is a part of the **Week-5 Apache Spark Assignment** during my **Data Engineering Internship at Celebal Technologies**.

The objective of this assignment is to understand how Apache Spark processes large datasets efficiently using **Spark DataFrames**, perform data cleaning, transformations, aggregations, and build a simple end-to-end ETL pipeline.

Unlike Hadoop MapReduce, Spark performs **in-memory computation**, enabling significantly faster execution for iterative workloads such as Machine Learning and large-scale analytics.

---

# 🎯 Objectives

- Understand Apache Spark Architecture
- Compare Spark with Hadoop MapReduce
- Learn Spark DataFrame APIs
- Perform Data Cleaning
- Handle Missing Values
- Remove Duplicate Records
- Apply Filtering & Transformations
- Perform Aggregations
- Understand Shuffle Operations
- Learn Wide vs Narrow Transformations
- Build a Simple ETL Pipeline

---

# 📂 Dataset Information

**Dataset Type:** Synthetic Sales Dataset

| Property | Value |
|----------|-------|
| Total Records | **1000** |
| Total Columns | **20** |
| File Format | CSV |
| Platform | Databricks |

### Dataset Columns

- transaction_id
- user_id
- transaction_date
- region
- product_category
- sale_amount
- status
- city
- state
- age
- subscription
- raw_timestamp
- email
- username
- price
- quantity
- store_id
- product_name
- discount_pct
- customer_segment

---

# 🛠️ Technologies Used

- Apache Spark
- PySpark
- Databricks
- Python
- Spark DataFrames

---

# 📁 Project Structure

```

spark-assignment/
│
├── data/
│ └── week5.csv
│
├── notebook/
│ └── spark_basics.ipynb
│
├── output/
│ └── results.csv
│
├── images/
│ ├── dataset_preview.png
│ ├── output.png
│ └── pipeline.png
│
└── README.md

```

---

# 📖 Assignment Workflow

```

Load Dataset
↓
Data Exploration
↓
Data Cleaning
↓
Handle Missing Values
↓
Remove Duplicates
↓
Apply Filters
↓
Transform Columns
↓
Aggregation
↓
GroupBy Operations
↓
Final ETL Pipeline
↓
Output Generation

```

---

# 📚 Concepts Covered

## Spark Fundamentals

- Apache Spark Architecture
- Spark Session
- DataFrames
- Lazy Evaluation
- DAG Execution
- Catalyst Optimizer

---

## Data Cleaning

- Handling Missing Values
- Removing Duplicate Records
- Data Validation
- Timestamp Processing

---

## Data Transformation

- Filtering Records
- Column Renaming
- Type Casting
- Timestamp Conversion

---

## Aggregations

- count()
- sum()
- avg()
- min()
- max()
- groupBy()
- agg()

---

## Spark Concepts

- Shuffle
- Wide Transformation
- Narrow Transformation
- In-Memory Computing
- MapReduce vs Spark
- Schema Inference

---

# 📚 Assignment Summary

This assignment was designed to build a strong foundation in **Apache Spark** by implementing real-world Data Engineering tasks using **PySpark DataFrames**. Instead of only answering theoretical questions, every concept was demonstrated on a real dataset through practical implementation, validation, and observations.

---

## Q1 – MapReduce Limitations vs Apache Spark

Compared the traditional Hadoop MapReduce framework with Apache Spark and explained why Spark is preferred for modern big data processing. Covered concepts such as:

- Disk-based processing in MapReduce
- In-Memory Computing in Spark
- High Disk I/O overhead
- Iterative Machine Learning workloads
- Spark Architecture
- Catalyst Optimizer
- Spark UI and execution workflow

---

## Q2 – In-Memory Computing

Explained how Apache Spark improves performance by storing intermediate data in memory instead of repeatedly reading and writing to disk.

Implemented and discussed:

- Spark Cache
- Persist
- Storage Levels
- Lazy Evaluation
- Fault Tolerance
- RDD Lineage

This demonstrated why Spark is significantly faster than Hadoop MapReduce for iterative algorithms.

---

## Q3 – Duplicate Record Removal

Implemented duplicate detection and removal using Spark DataFrames.

Performed:

- Duplicate identification
- Duplicate removal using business keys
- Before and After record comparison
- Validation of cleaned dataset

---

## Q4 – Filtering and Aggregation

Filtered the dataset based on region and calculated the average sales amount for each product category using:

- filter()
- groupBy()
- avg()

---

## Q5 – Handling Missing Values

Compared the behaviour of:

- `.na.drop()`
- `.na.fill()`

Analyzed missing values present in the dataset and demonstrated appropriate techniques for handling incomplete records.

---

## Q6 – Grouping Records

Grouped data by city and calculated record counts while filtering only those cities having more than 100 records.

Implemented:

- groupBy()
- count()
- filter()

---

## Q7 – DataFrame Immutability

Demonstrated that Spark DataFrames are immutable.

Showed that operations such as:

- drop()
- withColumnRenamed()

do not modify the original DataFrame but instead return a new DataFrame.

---

## Q8 – Filtering Records

Filtered customers whose:

- Age is between 18 and 30
- Subscription type is Premium

Performed validation by counting matching records.

---

## Q9 – Null Handling Before Aggregation

Demonstrated why missing values should be handled before performing mathematical aggregations.

Compared aggregation results before and after replacing NULL values.

Covered:

- sum()
- avg()
- count()

---

## Q10 – Timestamp Processing

Converted the raw timestamp column into TimestampType.

Handled multiple timestamp formats present in the dataset before conversion and renamed the column to **event_time**.

This demonstrates a common real-world ETL preprocessing task.

---

## Q11 – Shuffle and Wide Transformation

Explained Spark Shuffle during groupBy operations.

Covered:

- Narrow Transformations
- Wide Transformations
- Data Movement across partitions
- Network communication
- Execution Plan (Explain)

---

## Q12 – Data Quality Validation

Identified and removed records where:

- Email was NULL
- Username was NULL
- Username contained empty or whitespace values

Included validation before and after cleaning to ensure data quality.

---

## Q13 – Multiple Aggregations

Used the `.agg()` function to calculate multiple statistics simultaneously.

Calculated:

- Minimum Price
- Maximum Price
- Average Price

Demonstrated efficient aggregation using a single Spark operation.

---

## Q14 – Schema Inference

Analyzed the risks of using `inferSchema=True` when datasets contain inconsistent timestamp formats.

Explained:

- Incorrect Schema Inference
- Sampling-based Detection
- Parsing Errors
- Production Best Practices using StructType

---

## Q15 – End-to-End ETL Pipeline

Developed a complete Spark Data Processing Pipeline.

Pipeline Steps:

- Removed Duplicate Records
- Filled Missing Prices
- Calculated Revenue
- Grouped Data by Store
- Generated Store-wise Revenue Summary

The pipeline represents a simplified production ETL workflow commonly used in Data Engineering projects.

---

# 💡 Key Learning Outcomes

Through this assignment, I gained practical experience in:

- Apache Spark Fundamentals
- Spark DataFrames
- Data Cleaning
- Data Transformation
- Missing Value Handling
- Duplicate Removal
- Aggregations
- GroupBy Operations
- Shuffle Processing
- Wide vs Narrow Transformations
- Timestamp Processing
- Schema Inference
- Building End-to-End ETL Pipelines
- Writing clean and production-oriented PySpark code




# ☁️ Week 4 — Azure Cloud Fundamentals and Data Pipeline Implementation using Azure Data Factory

> **Celebal Excellence Internship (CEI '26) — Data Engineering Track**
> **Week 4 Assignment: Azure Cloud Concepts, Storage Account, Azure Data Factory, IAM & End-to-End Data Pipeline**

---

# 📌 Objective

The objective of this assignment was to understand core Azure cloud concepts and build a complete end-to-end data pipeline using Azure Blob Storage and Azure Data Factory.

The focus was not only on completing the tasks but also on understanding:

* Why Azure services are used
* How cloud resources interact with each other
* How secure access is implemented
* How data pipelines are designed in real-world environments
* How Azure Data Factory orchestrates data movement

This project provided hands-on experience with cloud infrastructure, storage services, data orchestration, metadata validation, monitoring, and security.

---

# 🏗️ Solution Architecture

```text
CSV File (Local)
      │
      ▼
Azure Blob Storage (raw-data)
      │
      ▼
Azure Data Factory
      │
      ├── Linked Service
      ├── Source Dataset
      ├── Get Metadata Activity
      └── Copy Data Activity
      │
      ▼
Azure Blob Storage (processed-data)
      │
      ▼
processed_superstore.csv
```

---

# 📊 Azure Resources Created

| Resource Type         | Resource Name  | Region         |
| --------------------- | -------------- | -------------- |
| Resource Group        | rg-CEI-Week4   | Central India  |
| Storage Account       | stceiweek4ks   | Southeast Asia |
| Azure Data Factory    | adf-cei-week4  | Southeast Asia |
| Source Container      | raw-data       | —              |
| Destination Container | processed-data | —              |

---

# 📘 Task 1 – Azure Portal Exploration & Resource Group Creation

## Activities Performed

* Explored Azure Portal interface
* Navigated through Azure services
* Understood Resource Groups and resource organization
* Created Resource Group

### Resource Group

```text
rg-CEI-Week4
```

### Additional Governance Configuration

Applied resource tags:

| Tag         | Value        |
| ----------- | ------------ |
| Environment | Development  |
| Project     | CEI-Week4    |
| Owner       | Kashish-Soni |
| Week        | Week-4       |

### Key Learning

Resource Groups are not merely folders; they act as logical containers for lifecycle management, access control, governance, and cost tracking.

---

# 📗 Task 2 – Storage Account Setup

## Storage Account Creation

Created Azure Storage Account:

```text
stceiweek4ks
```

Configuration:

* Standard Performance
* Locally Redundant Storage (LRS)
* Secure Transfer Enabled
* Private Blob Containers

---

## Blob Containers Created

### Source Container

```text
raw-data
```

Purpose:

Stores incoming source files.

### Destination Container

```text
processed-data
```

Purpose:

Stores processed output files.

---

## Dataset Upload

Uploaded:

```text
Sample-Superstore.csv
```

to:

```text
raw-data
```

### Security Consideration

Containers were configured with **Private Access** to prevent anonymous access to business data.

---

# 📙 Task 3 – Azure Data Factory Fundamentals

## Azure Data Factory Creation

Created Azure Data Factory instance:

```text
adf-cei-week4
```

---

## ADF Studio Exploration

Explored the three primary areas of ADF Studio:

### Author

Used for:

* Linked Services
* Datasets
* Pipelines
* Activities

### Monitor

Used for:

* Pipeline execution monitoring
* Success/Failure tracking
* Runtime diagnostics

### Manage

Used for:

* Linked Services
* Integration Runtime
* Security and Configuration

---

## Linked Service Configuration

Created Linked Service:

```text
BlobStorage_superstore
```

Purpose:

Provides connectivity between Azure Data Factory and Azure Blob Storage.

---

## Dataset Creation

### Source Dataset

```text
ds_superstore_source
```

References:

```text
raw-data/Sample-Superstore.csv
```

### Destination Dataset

```text
ds_superstore_destination
```

References:

```text
processed-data/processed_superstore.csv
```

---

# 🔍 Metadata Validation Pipeline

## Pipeline

```text
pl_get_metadata
```

## Activity

```text
Validate_Source_File
```

## Metadata Fields Retrieved

* Item Name
* File Size
* Last Modified Timestamp
* Structure (Schema)

### Metadata Output

| Property      | Value                 |
| ------------- | --------------------- |
| File Name     | Sample-Superstore.csv |
| File Size     | 2,287,806 bytes       |
| Last Modified | 2026-06-19T13:50:46Z  |
| Schema        | 21 Columns            |

---

## Why Metadata Validation?

Metadata validation ensures:

* File exists
* File is not empty
* Schema is available
* Source file is valid

This follows a **fail-fast** approach where validation occurs before processing begins.

---

# 📕 Task 4 – Pipeline Development

## Pipeline

```text
pl_copy_superstore
```

### Activities Used

1. Get Metadata
2. Copy Data

Pipeline Flow:

```text
Validate_Source_File
        │
        ▼
Copy_Superstore_Data
```

### Source

```text
raw-data/Sample-Superstore.csv
```

### Destination

```text
processed-data/processed_superstore.csv
```

---

# 📒 Task 5 – Pipeline Execution

Pipeline was executed using:

```text
Debug Run
```

Pipeline Status:

```text
Succeeded
```

---

## Monitoring

The Azure Data Factory Monitor tab was used to:

* Track execution status
* Validate successful runs
* Review activity outputs
* Troubleshoot failures

### Execution Result

* Metadata Validation: Success
* Copy Activity: Success
* Pipeline Status: Succeeded

---

# 📓 Task 6 – Identity and Access Management (IAM)

Implemented Azure Role-Based Access Control (RBAC).

---

## Reader Role

Provides:

* Read-only access

Purpose:

Monitoring and visibility without modification privileges.

---

## Contributor Role

Provides:

* Create resources
* Modify resources
* Delete resources

Cannot:

* Assign permissions

---

## Storage Blob Data Contributor

Assigned to Azure Data Factory Managed Identity.

Provides:

* Read Blob Data
* Write Blob Data
* Delete Blob Data

Purpose:

Allow ADF to securely access Azure Storage.

---

# 🔐 Managed Identity Implementation

ADF was granted access through a System-Assigned Managed Identity.

Benefits:

* No stored credentials
* No hardcoded secrets
* Passwordless authentication
* Recommended Azure security practice

---

# 🚀 Mini Project – End-to-End Data Pipeline

## Objective

Build a complete Azure Data Factory pipeline that:

1. Reads a CSV file from Azure Blob Storage
2. Validates metadata
3. Copies data to a new location
4. Monitors execution
5. Secures access using RBAC

---

## Final Pipeline Architecture

```text
Source CSV
     │
     ▼
Blob Storage (raw-data)
     │
     ▼
Get Metadata
     │
     ▼
Copy Data
     │
     ▼
Blob Storage (processed-data)
     │
     ▼
processed_superstore.csv
```

---

# 📈 Results

## Metadata Validation

Successfully validated:

* File Name
* File Size
* Last Modified Date
* Schema Structure

---

## Data Copy Validation

Source File:

```text
Sample-Superstore.csv
```

Destination File:

```text
processed_superstore.csv
```

### Data Integrity Verification

| Metric           | Value    |
| ---------------- | -------- |
| Source Size      | 2.18 MiB |
| Destination Size | 2.18 MiB |

Result:

✅ Zero data loss confirmed

---

## Pipeline Execution

| Activity     | Status    |
| ------------ | --------- |
| Get Metadata | Success   |
| Copy Data    | Success   |
| Pipeline     | Succeeded |

---

# ⭐ What Makes This Project Different?

Unlike a basic file-copy implementation, this project includes:

### Metadata Validation Before Processing

Validated:

* File existence
* File size
* Last modified timestamp
* Schema structure

before copying data.

---

### Layered Storage Architecture

```text
raw-data
    │
    ▼
processed-data
```

This mirrors enterprise Data Lake implementations.

---

### RBAC-Based Security

Implemented secure role assignments instead of unrestricted access.

---

### Managed Identity

Configured secure service-to-service authentication without storing credentials.

---

### Governance Through Tagging

Applied resource tags for:

* Ownership
* Environment
* Project Identification
* Resource Organization

---

### Monitoring and Validation

Used Azure Data Factory Monitor tab to track and verify execution.

---

# 🛠️ Tools & Technologies Used

* Microsoft Azure
* Azure Resource Groups
* Azure Blob Storage
* Azure Data Factory
* Azure IAM (RBAC)
* Managed Identity
* Azure Monitor
* CSV Dataset

---

# 📚 Key Learnings

Through this project, I gained practical experience with:

* Azure Cloud Fundamentals
* Azure Resource Management
* Azure Storage Account Configuration
* Azure Blob Storage
* Azure Data Factory
* Linked Services
* Datasets
* Metadata Validation
* Data Movement Pipelines
* Pipeline Monitoring
* IAM & RBAC
* Managed Identity
* Data Engineering Best Practices

---

# 🔮 Future Enhancements

The solution can be further improved by implementing:

* Event-Based Triggers
* Scheduled Pipelines
* Dynamic Parameters
* ForEach Activity for Multiple Files
* Data Quality Checks
* Incremental Data Loading
* Email Notifications
* Azure Data Lake Gen2
* CI/CD Integration using Git

---

# 🏁 Conclusion

This project successfully demonstrates a production-inspired Azure Data Factory solution capable of validating, processing, and securely moving data within Azure Blob Storage.

Beyond completing the required assignment tasks, additional effort was invested in understanding Azure architecture, IAM design, Managed Identity authentication, metadata validation, monitoring practices, governance through tagging, and production-oriented cloud engineering concepts.

The implementation reflects foundational practices used in modern Azure Data Engineering environments and provides a strong base for building scalable cloud data platforms.

---


# 🚀 Mini Project: End-to-End Data Pipeline using Azure Data Factory

> **Celebal Excellence Internship (CEI '26) – Data Engineering Track**
> **Week 4 Mini Project**

---

# 📌 Project Overview

This project demonstrates the implementation of an end-to-end cloud-based data pipeline using **Azure Blob Storage** and **Azure Data Factory (ADF)**.

The pipeline reads a CSV file from Azure Blob Storage, validates the file using metadata checks, and securely copies it to a destination container. The project also incorporates Azure IAM and Managed Identity concepts to follow secure and production-oriented cloud practices.

---

# 🎯 Problem Statement

Build a complete pipeline that:

* Reads a CSV file from Azure Blob Storage
* Validates metadata before processing
* Copies data to a new destination location
* Uses Azure Data Factory for orchestration
* Implements secure access using IAM and RBAC

---

# 🏗️ Solution Architecture

```text
Sample-Superstore.csv
        │
        ▼
Azure Blob Storage
(raw-data container)
        │
        ▼
Get Metadata Activity
(File Validation)
        │
        ▼
Copy Data Activity
        │
        ▼
Azure Blob Storage
(processed-data container)
        │
        ▼
processed_superstore.csv
```

---

# ☁️ Azure Services Used

| Service               | Purpose                           |
| --------------------- | --------------------------------- |
| Azure Resource Group  | Resource organization             |
| Azure Storage Account | Cloud storage                     |
| Azure Blob Storage    | Source and destination containers |
| Azure Data Factory    | Data orchestration                |
| Azure IAM (RBAC)      | Access management                 |
| Managed Identity      | Secure authentication             |

---

# 📦 Resources Created

| Resource              | Name                      |
| --------------------- | ------------------------- |
| Resource Group        | rg-CEI-Week4              |
| Storage Account       | stceiweek4ks              |
| Azure Data Factory    | adf-cei-week4             |
| Source Container      | raw-data                  |
| Destination Container | processed-data            |
| Linked Service        | BlobStorage_superstore    |
| Source Dataset        | ds_superstore_source      |
| Destination Dataset   | ds_superstore_destination |
| Pipeline              | pl_superstore_end_to_end  |

---

# 📂 Data Storage Design

## Source Layer

Container:

```text
raw-data
```

Purpose:

* Stores original source files
* Preserves raw data for reprocessing

---

## Processed Layer

Container:

```text
processed-data
```

Purpose:

* Stores processed output files
* Used for downstream consumption

---

# 🔗 Linked Service Configuration

Created Linked Service:

```text
BlobStorage_superstore
```

Purpose:

* Establish secure connectivity between Azure Data Factory and Azure Blob Storage.

---

# 📊 Dataset Configuration

## Source Dataset

```text
ds_superstore_source
```

References:

```text
raw-data/Sample-Superstore.csv
```

---

## Destination Dataset

```text
ds_superstore_destination
```

References:

```text
processed-data/processed_superstore.csv
```

---

# 🔍 Metadata Validation

Pipeline Activity:

```text
Validate_Source_File
```

Activity Type:

```text
Get Metadata
```

Metadata Retrieved:

* Item Name
* File Size
* Last Modified Timestamp
* File Structure (Schema)

### Metadata Output

| Property      | Value                 |
| ------------- | --------------------- |
| File Name     | Sample-Superstore.csv |
| File Size     | 2,287,806 bytes       |
| Last Modified | 2026-06-19T13:50:46Z  |
| Schema        | 21 Columns            |

### Why Metadata Validation?

Metadata validation ensures:

* Source file exists
* File is not empty
* Schema is available
* File is ready for processing

This follows the **fail-fast principle**, where validation occurs before any data movement takes place.

---

# 🔄 Data Movement Pipeline

Pipeline Name:

```text
pl_superstore_end_to_end
```

Pipeline Flow:

```text
Validate_Source_File
        │
        ▼
Copy_Superstore_Data
```

Source:

```text
raw-data/Sample-Superstore.csv
```

Destination:

```text
processed-data/processed_superstore.csv
```

---

# 📈 Monitoring and Execution

Execution Method:

```text
Debug Run
```

Monitoring Tool:

```text
ADF Monitor Tab
```

The Monitor tab was used to:

* Track pipeline execution
* Review activity status
* Validate successful execution
* Troubleshoot failures

---

# 🔐 Security Implementation

## IAM Roles Configured

### Reader

Provides read-only access.

### Contributor

Provides resource management permissions.

### Storage Blob Data Contributor

Assigned to Azure Data Factory Managed Identity.

Provides:

* Read Blob Data
* Write Blob Data
* Delete Blob Data

---

# 🆔 Managed Identity

Implemented Azure Data Factory Managed Identity for secure access.

Benefits:

* No hardcoded credentials
* No secret management
* Passwordless authentication
* Enterprise security best practice

---

# 📊 Results Summary

| Validation Check         | Status |
| ------------------------ | ------ |
| Source File Detected     | ✅      |
| Metadata Retrieved       | ✅      |
| File Size Validated      | ✅      |
| Schema Validated         | ✅      |
| Copy Data Activity       | ✅      |
| Destination File Created | ✅      |
| Pipeline Execution       | ✅      |
| Data Integrity Verified  | ✅      |

---

# 📋 Output Validation

### Source File

```text
Sample-Superstore.csv
```

Size:

```text
2.18 MiB
```

---

### Destination File

```text
processed_superstore.csv
```

Size:

```text
2.18 MiB
```

### Data Integrity Check

Source Size = Destination Size

✅ Zero Data Loss Confirmed

---

# ⭐ What Makes This Project Different?

Unlike a basic file-copy implementation, this project includes:

* Metadata validation before processing
* Separate raw and processed storage layers
* RBAC-based security configuration
* Managed Identity implementation
* Enterprise-style resource tagging
* Pipeline monitoring and validation
* Meaningful activity naming conventions
* Production-oriented architecture decisions

---

# 📚 Key Learnings

Through this project, I gained practical experience with:

* Azure Cloud Fundamentals
* Azure Blob Storage
* Azure Data Factory
* Linked Services
* Datasets
* Get Metadata Activity
* Copy Data Activity
* Pipeline Monitoring
* IAM & RBAC
* Managed Identity
* Cloud Security Best Practices
* Data Engineering Fundamentals

---

# 💭 Personal Reflection

Before this project, Azure Data Factory, Blob Storage, IAM, and Managed Identity were completely new concepts to me.

Through this implementation, I learned how cloud services interact, how secure access is managed using RBAC, and why metadata validation is important before processing data.

The most valuable learning was understanding that data engineering is not only about moving data. It also involves security, governance, monitoring, reliability, and maintainability.

---

# 🚀 Future Enhancements

* Event-Based Triggers
* Scheduled Pipeline Execution
* Dynamic Parameters
* ForEach Activity for Multiple Files
* Data Quality Checks
* Incremental Data Loading
* Email Notifications
* Azure Data Lake Gen2 Integration
* CI/CD using Git

---

# 🏁 Conclusion

This project successfully demonstrates a production-inspired Azure Data Factory solution capable of validating, processing, and securely moving data within Azure Blob Storage.

By incorporating metadata validation, layered storage architecture, IAM, RBAC, Managed Identity, monitoring, and governance practices, the solution goes beyond a basic file-copy implementation and reflects foundational principles used in modern cloud data engineering environments.

---



# 📊 Week - 3  Customer Sales Analysis & Data Modelling using SQL

## 📌 Objective

The objective of this project was to build a structured analytical workflow using SQL by transforming raw transactional sales data into meaningful customer insights.

The project goes beyond basic querying and covers data validation, data quality assessment, relational data modelling, customer analytics, ranking analysis, and business-oriented reporting using advanced SQL concepts such as Subqueries, Common Table Expressions (CTEs), and Window Functions.

The goal was not only to retrieve data but also to understand how SQL can be used to support business decision-making through customer-centric analytics.

---

## 🛠️ Technologies Used

- SQL
- MySQL
- MySQL Workbench

---

## 📂 Dataset Overview

The project was built using the Superstore sales dataset containing customer, product, and transaction-level information.

### Key Attributes

- Customer Information
- Order Information
- Product Information
- Sales Metrics
- Profit Metrics
- Discounts
- Shipping Information

The dataset contains nearly 10,000 transaction records representing customer purchases across multiple product categories and regions.

---

# 🔄 Project Workflow

## 1️⃣ Database Setup

The project began by creating and configuring a dedicated database environment.

### Activities Performed

- Database Creation
- Data Import Validation
- Schema Verification

This ensured the dataset was successfully loaded and ready for analysis.

---

## 2️⃣ Data Validation & Data Quality Assessment

Before performing any analysis, multiple validation checks were conducted to ensure data reliability.

### Validation Checks Performed

- Dataset Structure Validation
- Row Count Verification
- Distinct Order Analysis
- NULL Value Detection
- Duplicate Record Analysis
- Negative Sales Validation
- Negative Quantity Validation
- Date Range Verification
- Customer Data Validation

### Key Findings

- No NULL values were found in critical business columns.
- Customer IDs were consistently mapped to customer names.
- No duplicate Row IDs were detected.
- Several duplicate Order ID and Product ID combinations were identified and investigated.

### Data Quality Insight

Duplicate Order ID and Product ID combinations were not treated as data errors because detailed inspection revealed differences in sales, quantity, and profit values.

These records represented valid transaction line items rather than duplicate transactions.

---

## 3️⃣ Data Modelling

To improve analytical flexibility, the raw dataset was transformed into a simplified relational structure.

### Tables Created

#### Customers

Stores customer-level information:

- Customer ID
- Customer Name
- Segment

#### Products

Stores product-related information:

- Product ID
- Product Name
- Category
- Sub-Category

#### Orders

Stores transactional sales information:

- Order ID
- Customer ID
- Product ID
- Sales
- Quantity
- Discount
- Profit

### Data Modelling Activities

- Primary Key Analysis
- Business Key Validation
- Duplicate Detection
- Data Type Optimization

### Key Finding

Customer IDs were unique and suitable for primary key implementation.

However, Product IDs were not completely unique. Investigation revealed that certain Product IDs were associated with multiple product descriptions, indicating source-data inconsistencies.

As a result, Product ID was not enforced as a primary key.

---

## 4️⃣ Advanced SQL Analysis

The project demonstrates practical use of advanced SQL concepts to answer business questions.

### Subqueries

Used to:

- Identify orders above average sales
- Compare customer performance against business benchmarks
- Retrieve customer-specific maximum sales values

### Common Table Expressions (CTEs)

Used to:

- Create reusable analytical layers
- Simplify complex aggregations
- Improve query readability and maintainability

### Window Functions

Implemented:

- DENSE_RANK()
- ROW_NUMBER()
- PARTITION BY

These functions enabled customer ranking, revenue analysis, and purchase sequence tracking.

---

# 📈 Customer Analytics Performed

## Total Sales by Customer

Customer-level sales were aggregated to determine revenue contribution across the customer base.

### Insight

Revenue was heavily concentrated among a relatively small group of customers.

---

## Above-Average Customers

Customer sales were compared against average customer revenue.

### Insight

Several customers generated significantly higher revenue than the overall customer average, making them strong candidates for retention and loyalty initiatives.

---

## Customer Ranking

Customers were ranked using DENSE_RANK() based on total revenue generated.

### Insight

Revenue-based ranking provides a structured view of customer contribution and helps identify strategic customers.

---

## Order Sequence Analysis

ROW_NUMBER() and PARTITION BY were used to generate customer-specific purchase sequences.

### Insight

Order sequencing enables customer journey analysis and repeat-purchase tracking.

---

## Top Customer Analysis

Top-performing customers were identified using ranking-based approaches.

### Insight

A small percentage of customers contributed a disproportionately large share of total sales, highlighting revenue concentration patterns.


# 🎯 Mini Project: Customer Sales Insights

The final phase of the project focused on customer-centric analytics, where transactional sales data was transformed into actionable business insights using advanced SQL techniques.

Rather than simply retrieving records, the objective was to understand customer behavior, measure revenue contribution, identify high-value customers, and uncover patterns that can support data-driven business decisions.

The analysis combined Aggregations, Subqueries, Common Table Expressions (CTEs), and Window Functions to answer practical business questions commonly encountered in Customer Analytics and Business Intelligence environments.

---

## 📌 Business Questions Addressed

### 1️⃣ Top Revenue-Generating Customers

Customers were ranked based on their total sales contribution to identify the most valuable customers in the business.

#### Business Impact

High-value customers contribute a significant share of overall revenue. Identifying these customers helps organizations prioritize retention efforts, loyalty programs, and personalized marketing initiatives.

---

### 2️⃣ Low-Contributing Customers

Customers generating the lowest revenue were identified through ranking analysis.

#### Business Impact

Understanding low-performing customer segments helps businesses uncover engagement gaps and develop targeted reactivation strategies.

---

### 3️⃣ One-Time Buyer Analysis

Customer order frequency was analyzed to identify customers who placed only a single order.

#### Business Impact

One-time buyers often represent the highest churn-risk segment. Monitoring these customers enables businesses to improve repeat-purchase rates and customer retention.

---

### 4️⃣ Above-Average Revenue Customers

Customer-level sales were compared against overall average customer revenue.

#### Business Impact

This analysis provides a simple yet effective customer segmentation framework by distinguishing high-performing customers from the broader customer base.

---

### 5️⃣ Peak Purchase Analysis

The highest-value order placed by each customer was identified.

#### Business Impact

Peak purchase behavior reveals customer spending capacity and helps businesses identify opportunities for premium offerings, upselling, and personalized recommendations.

---

## ⚙️ Advanced SQL Techniques Applied

To make the analysis more scalable and business-oriented, advanced SQL concepts were incorporated throughout the project:

- Common Table Expressions (CTEs) for modular and reusable analytical logic
- Subqueries for benchmark-based comparisons
- DENSE_RANK() for customer ranking and performance analysis
- ROW_NUMBER() with PARTITION BY for customer purchase sequencing
- JOIN operations for integrating customer and transaction-level information

---

## 📊 Key Analytical Findings

- Revenue is highly concentrated among a relatively small group of customers.
- Several customers generate substantially higher revenue than the overall customer average.
- One-time buyers represent a significant retention opportunity.
- Customer rankings provide a clear view of revenue contribution across the customer base.
- Peak order analysis highlights customers with strong purchasing power.

---

## 🚀 Business Value Delivered

This mini-project demonstrates how SQL can be used beyond traditional data retrieval to perform customer analytics, revenue analysis, and business reporting.

By combining customer-level aggregations, ranking techniques, and benchmark comparisons, the project transforms raw transactional data into meaningful insights that can support customer retention strategies, revenue optimization, and strategic business decision-making.







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
