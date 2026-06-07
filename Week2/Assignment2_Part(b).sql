-- -------------------------------------------------
-- STEP 1: Steps: 1.Load dataset into a SQL database
-- -------------------------------------------------

CREATE DATABASE sales_analysis;
USE sales_analysis;
DESCRIBE superstore_sales;

-- ---------------------------------------------
--   STEP 2:Explore table (schema, sample data)
-- ---------------------------------------------

-- 2.1
SELECT *
FROM superstore_sales
LIMIT 10;

-- 2.2
SELECT COUNT(*) as Total_rows
FROM superstore_sales;

-- 2.3
SHOW COLUMNS
FROM superstore_sales;

-- 2.4
SELECT DISTINCT Region
FROM superstore_sales;

-- 2.5
SELECT DISTINCT Category
FROM superstore_sales;

/*
The dataset contains 9,994 sales transactions across multiple regions,
customer segments, and product categories.
The table includes sales, profit, discount, quantity,
customer information, and product information,
making it suitable for sales and profitability analysis.
*/
 
-- 2.6 Data Range 
SELECT
    MIN(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS first_order,
    MAX(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS last_order
FROM superstore_sales;


-- 2.7 NULL Audit
SELECT
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN `Order Date` IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN `Product ID` IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS null_profit
FROM superstore_sales;

-- NULL auditing helps assess data completeness
-- before performing any analysis.
-- Missing values in critical fields can affect
-- aggregations, reporting, and business decisions.


-- --------------------------------------------------------------
-- STEP 3 :- Apply WHERE filters (region, category, date, sales).
-- --------------------------------------------------------------

-- WHERE clause is used to filter rows based on
-- specified conditions.
-- It allows us to retrieve only the records
-- that satisfy the given criteria instead of
-- scanning the entire dataset.
-- 3.1 Regional Analysis — Central Region

SELECT
    `Order ID`,
    `Order Date`,
    `Customer Name`,
    `Product Name`,
    Sales,
    Profit
FROM superstore_sales
WHERE Region = 'Central'
ORDER BY Sales DESC
LIMIT 10;

-- Insight
-- This query highlights high-performing sales transactions
-- from the Central region and helps identify strong regional markets.

-- 3.2 Category Analysis — Technology

SELECT
    `Order ID`,
    `Product Name`,
    `Sub-Category`,
    Sales,
    Quantity,
    Profit
FROM superstore_sales
WHERE Category = 'Technology'
ORDER BY Sales DESC
LIMIT 10;

-- Insight
-- Technology products typically contribute
-- a significant share of revenue and profit.

-- 3.3 High-Value Orders

SELECT
    `Order ID`,
    `Customer Name`,
    `Product Name`,
    Category,
    Sales,
    Quantity,
    Discount,
    Profit
FROM superstore_sales
WHERE Sales > 1000
ORDER BY Sales DESC
LIMIT 5;

-- Insight
-- High-value transactions help identify
-- premium products and high-spending customers.

-- 3.4 Loss-Making Transactions

SELECT
    `Order ID`,
    `Product Name`,
    `Sub-Category`,
    Sales,
    Discount,
    Profit
FROM superstore_sales
WHERE Profit < 0
ORDER BY Profit ASC
LIMIT 10;

-- Insight
-- Negative-profit transactions indicate
-- pricing, discounting, or operational issues.

-- 3.5 Heavy Discount Analysis

SELECT
    `Customer Name`,
    `Product Name`,
    Category,
    Sales,
    Discount,
    Profit
FROM superstore_sales
WHERE Discount > 0.30
ORDER BY Discount DESC
LIMIT 5;

-- Insight
-- Higher discounts can increase sales volume
-- but may reduce profitability.

-- 3.6 Combined Filter

SELECT
    `Order ID`,
    `Customer Name`,
    `Product Name`,
    Sales,
    Profit
FROM superstore_sales
WHERE Region = 'West'
AND Category = 'Technology'
AND Sales > 1000
ORDER BY Sales DESC
LIMIT 4 ;

-- 3.7 High Sales but Negative Profit

SELECT
    `Order ID`,
    `Product Name`,
    Sales,
    Discount,
    Profit
FROM superstore_sales
WHERE Sales > 500
AND Profit < 0
ORDER BY Sales DESC
LIMIT 3;

-- This analysis highlights products that generate
-- strong revenue but fail to generate profit,
-- often due to excessive discounting or operational costs.

-- Such products should be reviewed because high sales
-- do not always translate into business success.

-- ------------------------------------------------------------------
-- STEP 4: Use GROUP BY for aggregations (sales, quantity, averages)
-- ------------------------------------------------------------------

-- GROUP BY is used to organize rows into groups
-- based on one or more columns.

-- Once groups are formed, aggregate functions such as:
-- SUM()
-- AVG()
-- COUNT()
-- MIN()
-- MAX()
-- can be applied to summarize the data.

-- Examples:
-- Total Sales by Region
-- Revenue by Product Category
-- Average Profit by State
-- Quantity Sold by Product

-- 4.1 Regional Performance Analysis

SELECT
    Region,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,
    ROUND(
        SUM(Profit)/SUM(Sales)*100,
        2
    ) AS profit_margin_pct
FROM superstore_sales
GROUP BY Region
ORDER BY total_sales DESC;

-- Profit Margin (%) = Profit / Sales × 100
-- Regions generating high revenue but low margins
-- may require pricing, discount, or cost optimization.
-- This analysis helps identify both growth opportunities
-- and efficiency gaps across geographic markets.


-- 4.2 Category Performance Analysis
SELECT
    Category,
    COUNT(*) AS line_items,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,
    ROUND(AVG(Sales),2) AS avg_sale_per_item,
    ROUND(
        SUM(Profit)/SUM(Sales)*100,
        2
    ) AS profit_margin_pct
FROM superstore_sales
GROUP BY Category
ORDER BY total_profit DESC;

-- High revenue does not always translate
-- into high profitability.

-- A category generating strong sales but weak margins
-- should be reviewed for excessive discounting,
-- supply chain costs, or pricing issues.

-- 4.3 Sub-Category Profitability
SELECT
    `Sub-Category`,
    Category,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,
    ROUND(
        SUM(Profit)/SUM(Sales)*100,2
    ) AS profit_margin_pct,
    CASE
        WHEN SUM(Profit) < 0
            THEN 'LOSS-MAKING'
        WHEN SUM(Profit)/SUM(Sales) < 0.05
            THEN 'LOW MARGIN'
        WHEN SUM(Profit)/SUM(Sales) < 0.20
            THEN 'HEALTHY'
        ELSE 'STAR'
    END AS profitability_flag
FROM superstore_sales
GROUP BY `Sub-Category`, Category
ORDER BY total_profit DESC
LIMIT 2;

-- CASE is used to convert numerical metrics
-- into business-friendly performance categories.
-- This allows stakeholders to quickly identify
-- profitable and underperforming product groups.

-- Business Insight:
-- Products classified as LOSS-MAKING
-- require immediate business attention.
-- STAR categories can be prioritized
-- for growth and expansion initiatives.


-- 4.4 Customer Segment Performance Analysis
SELECT
    Segment,
    COUNT(DISTINCT `Customer ID`) AS customers,
    COUNT(DISTINCT `Order ID`) AS orders,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(AVG(Sales),2) AS avg_order_value,
    ROUND(
        SUM(Profit)/SUM(Sales)*100,
        2
    ) AS margin_pct
FROM superstore_sales
GROUP BY Segment
ORDER BY total_sales DESC
LIMIT 2;


-- Theory:
-- This query evaluates business performance across
-- different customer segments.

-- COUNT(DISTINCT Customer ID) measures the number
-- of unique customers in each segment.

-- COUNT(DISTINCT Order ID) shows the total number
-- of orders placed by each segment.

-- SUM(Sales) calculates the total revenue generated
-- by a customer segment.

-- AVG(Sales) represents the average order value,
-- helping identify segments with higher spending behavior.

-- Profit Margin (%) is calculated as:
-- (Total Profit / Total Sales) × 100

-- This metric indicates how efficiently revenue
-- is converted into profit.

-- Revenue tells us who buys the most,
-- but profit margin tells us who creates the most value.

-- Segments generating both high revenue and strong
-- profit margins can be prioritized for customer
-- retention programs, loyalty benefits, and
-- targeted marketing campaigns.


-- **** HAVING ****

-- WHERE filters rows before aggregation.
-- HAVING filters groups after aggregation.
-- HAVING is used when conditions depend on
-- aggregate functions such as SUM(), AVG(), COUNT().

SELECT
    State,
    ROUND(SUM(Sales),2) AS total_sales
FROM superstore_sales
GROUP BY State
HAVING SUM(Sales) > 100000
ORDER BY total_sales DESC;

-- Insight
-- HAVING helps focus on meaningful business groups
-- while removing low-contributing segments
-- from executive reports.


-- -----------------------------------------------------------
--  STEP 5 : Sort and limit results (top products, top categories)
-- -----------------------------------------------------------

-- ORDER BY is used to sort query results in ascending
-- or descending order based on a selected column.

-- LIMIT is used to restrict the number of rows returned.

-- Together, ORDER BY and LIMIT help identify the
-- highest and lowest performing entities in a dataset.

-- Ranking analysis is widely used in business reporting,
-- dashboard creation, customer analytics, and product
-- performance evaluation.

-- Instead of analyzing thousands of transactions,
-- decision-makers can focus on the most important
-- contributors to revenue and profitability.


-- 5.1 Top 10 Customers by Revenue

SELECT
    `Customer ID`,
    `Customer Name`,
    Segment,
    Region,
    COUNT(DISTINCT `Order ID`) AS orders_placed,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit
FROM superstore_sales
GROUP BY `Customer ID`, `Customer Name`, Segment, Region
ORDER BY total_sales DESC
LIMIT 10;

-- This query identifies the customers generating
-- the highest revenue for the business.
-- In addition to sales, it also measures
-- order frequency and profitability.

-- A small percentage of customers often contribute
-- a disproportionately large share of total revenue.
-- This pattern is commonly explained by the
-- Pareto Principle (80/20 Rule).

-- 5.2 Top 5 Products by Sales

SELECT
    `Product ID`,
    `Product Name`,
    Category,
    `Sub-Category`,
    ROUND(SUM(Sales),2) AS total_sales,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Profit),2) AS total_profit
FROM superstore_sales
GROUP BY `Product ID`, `Product Name`, Category, `Sub-Category`
ORDER BY total_sales DESC
LIMIT 5;

-- This query ranks products based on
-- total revenue generated.
-- It also includes quantity sold and profit
-- to provide a more complete view of performance
-- Products with consistently high sales
-- represent strong market demand.

-- 5.3 Bottom 5 Products by Profit (Loss-Making Products)

SELECT
    `Product Name`,
    `Sub-Category`,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,

    ROUND(
        SUM(Profit)/SUM(Sales)*100,
        2
    ) AS margin_pct

FROM superstore_sales
GROUP BY `Product ID`, `Product Name`, `Sub-Category`
ORDER BY total_profit ASC
LIMIT 5;

-- Revenue alone cannot determine product success.
-- A product may generate strong sales
-- while simultaneously reducing profitability.
-- Therefore, profit and profit margin must be
-- analyzed alongside revenue.


-- 5.4 Top 5 States by Revenue
SELECT
    State,
    Region,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit
FROM superstore_sales
GROUP BY State, Region
ORDER BY total_sales DESC
LIMIT 5;

-- This query identifies the highest revenue-generating
-- states across the business.
-- Geographic analysis helps organizations understand
-- where demand is strongest.

-- High-performing states represent key markets
-- and may justify increased marketing investment,
-- distribution capacity, and inventory allocation.


-- ---------------------------------------------------------------
-- 6.Solve use cases (monthly trends, top customers, duplicates)
-- ----------------------------------------------------------------

-- 6.1 Monthly Sales Trend Analysis
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
        '%Y-%m'
    ) AS YearMonth,
    ROUND(SUM(Sales),2) AS monthly_sales,
    ROUND(SUM(Profit),2) AS monthly_profit,
    COUNT(DISTINCT `Order ID`) AS total_orders
FROM superstore_sales
GROUP BY YearMonth
ORDER BY YearMonth;

-- Trend analysis is used to evaluate business performance
-- over time and identify seasonal patterns.
-- Monthly aggregation provides a high-level view of
-- revenue, profitability, and order volume.


-- 6.2 Customer Retention Analysis

SELECT buyer_type,
    COUNT(*) AS customers,
    ROUND(AVG(total_sales),2) AS avg_lifetime_sales
FROM
( SELECT `Customer ID`,
        CASE
            WHEN COUNT(DISTINCT `Order ID`) = 1
                THEN 'One-Time Buyer'
            WHEN COUNT(DISTINCT `Order ID`) <= 5
                THEN 'Occasional Buyer'
            ELSE 'Loyal Customer'
        END AS buyer_type,
        SUM(Sales) AS total_sales
    FROM superstore_sales
    GROUP BY `Customer ID`
) t
GROUP BY buyer_type
ORDER BY avg_lifetime_sales DESC;

-- Customer retention is often more cost-effective
-- than acquiring new customers.
-- Loyal customers typically generate higher lifetime value
-- and contribute significantly to long-term revenue.

-- 6.3 Duplicate Order Analysis 

SELECT
    `Order ID`,
    COUNT(*) AS occurrence
FROM superstore_sales
GROUP BY `Order ID`
HAVING COUNT(*) > 1
ORDER BY occurrence DESC;

-- HAVING is used because COUNT(*) is an aggregate value.
-- This query identifies Order IDs appearing
-- more than once in the dataset.

-- Multiple occurrences of an Order ID do not
-- necessarily indicate duplicate data.
-- A single order can contain multiple products,
-- resulting in multiple rows for the same Order ID.
-- Therefore, these records represent valid
-- transactional behavior rather than data-quality issues.


-- ----------------------------------------------------
-- 7.Validate results (row counts, data quality)
-- ----------------------------------------------------

-- Data validation is the process of verifying that
-- the dataset is complete, consistent, and reliable.

-- Before drawing business conclusions,
-- analysts must ensure that the underlying data
-- does not contain missing values, invalid records,
-- or unexpected inconsistencies.

-- Data quality checks improve confidence in the results
-- and reduce the risk of incorrect business decisions.


-- 7.1 Dataset Summary Validation

SELECT
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,
    SUM(Quantity) AS total_units_sold,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT `Order ID`) AS unique_orders,
    COUNT(DISTINCT `Customer ID`) AS unique_customers,
    COUNT(DISTINCT `Product ID`) AS unique_products
FROM superstore_sales;


-- Provides a high-level summary of the entire dataset
-- and verifies that all records were imported correctly.

-- 7.2 Missing Values Check
SELECT
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS null_profit,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS null_customers
FROM superstore_sales;

-- Missing values can impact aggregations,
-- reporting accuracy, and business decisions.

-- This query checks critical business fields
-- in a single execution.

-- 7.3 Check for Impossible Values

SELECT 'Negative Sales' AS check_type,
COUNT(*) AS violations
FROM superstore_sales
WHERE Sales < 0

UNION ALL

SELECT 'Zero Quantity',
COUNT(*)
FROM superstore_sales
WHERE Quantity <= 0

UNION ALL

SELECT 'Discount Greater Than 100%',
COUNT(*)
FROM superstore_sales
WHERE Discount > 1;

-- Validation rules help identify records that
-- violate expected business logic.
-- Such records may indicate data-entry errors
-- or data-quality issues.




-- =====================================================
--   CONCLUSION
-- =====================================================

-- The analysis revealed significant differences in
-- performance across regions, categories, and customer segments.

-- Technology emerged as a strong revenue contributor,
-- while profitability analysis highlighted products
-- and transactions that require further investigation.

-- Customer retention analysis showed the importance
-- of loyal customers in driving long-term revenue.

-- Data quality validation confirmed that the dataset
-- was suitable for analysis and reporting.

-- Overall, SQL was used not only for data retrieval
-- but also for generating actionable business insights
-- that can support decision-making.









