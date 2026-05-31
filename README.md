# Week 1 - Product Data Exploration and Cleaning using Pandas

## Objective

The objective of this assignment was to learn Python fundamentals and perform data exploration, cleaning, transformation, and feature engineering using the Pandas library on a real-world e-commerce dataset.

---

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

also learnt to handle the duplicate values

---

### 6. Feature Engineering

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
