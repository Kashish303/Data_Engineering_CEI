-- ----------------------------------------------
-- PART 1 : DATABASE SETUP 
-- ----------------------------------------------

-- 1.1 Create database
CREATE DATABASE superstore;
-- 23:59:44	PREPARE stmt FROM 'INSERT INTO `superstore`.`superstore_raw` (`Row ID`,`Order ID`,`Order Date`,`Ship Date`,`Ship Mode`,`Customer ID`,`Customer Name`,`Segment`,`Country`,`City`,`State`,`Postal Code`,`Region`,`Product ID`,`Category`,`Sub-Category`,`Product Name`,`Sales`,`Quantity`,`Discount`,`Profit`) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'	OK	0.000 sec


-- 1.2 Using database
USE superstore;
-- 00:01:42	DEALLOCATE PREPARE stmt	OK	0.000 sec


-- ------------------------------
-- PART 2 : DATA VALIDATION 
-- ------------------------------

-- 2.1 Checking the dataset columns 
DESCRIBE superstore_raw;

-- 2.2 Number of rows in the dataset
SELECT COUNT(*) totalRows
 FROM superstore_raw;

-- 2.3 Distinct orders in dataset
SELECT COUNT(DISTINCT `Order ID`) AS TotalOrders
FROM superstore_raw;

-- 2.4 Checking for null sales
SELECT `Customer ID`,
`Order Id`,
Sales 
FROM superstore_raw
WHERE Sales IS NULL;

-- 2.5 Checking for null customer id
SELECT `Customer ID`,
`Order ID`,
Sales
FROM superstore_raw
WHERE `Customer ID` IS NULL;


-- 2.6 Checking Data Duplicacy
SELECT `Order ID` ,`Product ID`, COUNT(*)
FROM superstore_raw
GROUP BY `Order ID`,`Product ID`
HAVING COUNT(*)>1;   


-- 2.7 Checking the specific order
SELECT `Customer ID`,
`Order ID`,
`Product ID`
`Customer Name`,
`Order Date`
FROM superstore_raw
WHERE `Order ID`='CA-2016-129714'
AND `Product ID`='OFF-PA-10001970';

-- A duplicate analysis was performed using the combination of Order ID and Product ID.
-- Although some combinations appeared more than once, detailed inspection showed differences in Sales, Quantity, and Profit values.
-- Therefore, these records were treated as valid transaction line items rather than duplicate records, and no rows were removed.

-- 2.8 Checking for negative sales and quantity
SELECT `Customer ID`,
`Order ID`,
`Product ID`
`Customer Name`,
`Order Date`
FROM superstore_raw
WHERE sales<0 OR quantity<0;


-- 2.9 Checking for the loss 
SELECT COUNT(*) ordersWithLoss
FROM superstore_raw
WHERE profit<0;


-- 2.10 Date Range Validation 
SELECT MIN(`Order Date`) startDate,
MAX(`Order Date`) lastDate
FROM superstore_raw;
-- This shows in what date range our dataset is;
-- This is the dataset from 1/1/2017 to 9/9/2017


-- 2.11 Check customer IDs without names
SELECT `Customer Id`,
`Customer Name`
FROM superstore_raw
WHERE `Customer ID` IS NOT NULL
AND `Customer Name` IS NULL;
-- No customer was found


-- 2.12 Check duplicate row id
SELECT `Row ID`,
       COUNT(*) totalRows
FROM superstore_raw
GROUP BY `Row ID`
HAVING COUNT(*) > 1;
-- No customer was found satisfying this condition



-- ------------------------------------
-- PART 3 : DATA MODELLING
-- ------------------------------------

-- 3.1 ***** CREATING CUSTOMER TABLE *****

CREATE TABLE customers AS
SELECT DISTINCT
	`Customer ID`,
	`Customer Name`,
    `Segment`
FROM superstore_raw;
-- 12:47:20	CREATE TABLE customers AS SELECT DISTINCT  `Customer ID`,  `Customer Name`,     `Segment` FROM superstore_raw	793 row(s) affected Records: 793  Duplicates: 0  Warnings: 0	0.063 sec


-- 3.2 Checking for duplicate customer ID
SELECT `Customer ID`,
       COUNT(*) totalRows
FROM customers
GROUP BY `Customer ID`
HAVING COUNT(*) > 1;
-- We did not get any row which means that we do not have any duplicate customer ID 
-- We can make it a primary key easily



-- 3.3 Altering table 
ALTER TABLE customers
MODIFY COLUMN `Customer ID` VARCHAR(20);
-- 12:42:54	ALTER TABLE customers MODIFY COLUMN `Customer ID` VARCHAR(20)	4622 row(s) affected Records: 4622  Duplicates: 0  Warnings: 0	0.125 sec

-- The CREATE TABLE AS SELECT (CTAS) operation inferred the column
-- as a TEXT datatype. Since primary keys cannot be created on TEXT
-- columns directly, the datatype was modified to VARCHAR(20).


-- 3.4 PRIMARY KEY of Table Customers
ALTER TABLE customers
ADD PRIMARY KEY (`Customer ID`);
-- 12:49:10	ALTER TABLE customers ADD PRIMARY KEY (`Customer ID`)	0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.094 sec



-- 3.5 ***** CREATING TABLE PRODUCTS *****

CREATE TABLE products AS
SELECT DISTINCT
    `Product ID`,
    `Product Name`,
    Category,
    `Sub-Category`
FROM superstore_raw;
-- 12:56:07	CREATE TABLE products AS SELECT DISTINCT     `Product ID`,     `Product Name`,     Category,     `Sub-Category` FROM superstore_raw	1842 row(s) affected Records: 1842  Duplicates: 0  Warnings: 0	0.360 sec



-- 3.6 Checking for product ID duplicacy
SELECT `Product ID`,
        COUNT(*) totalCount
FROM products
GROUP BY `Product ID`
HAVING COUNT(*) > 1;

-- Product ID is expected to uniquely identify a product, however multiple Product IDs
-- appear more than once in the Products table. This indicates potential data quality
-- issues or inconsistencies in product metadata.
-- 30 Product IDs were found with duplicate occurrences, highlighting the importance
-- of business-key validation during data profiling and quality assessment.


-- 3.7 Checking for a specific Product ID
SELECT *
FROM products
WHERE `Product ID`='FUR-FU-10004848';

-- Data Quality Finding:
-- Certain Product IDs were associated with multiple Product Names.
-- This violates the expected uniqueness of Product ID and indicates
-- inconsistencies in the source data.
-- Therefore Product ID was not enforced as a primary key.


-- 3.8 ***** CREATING TABLE ORDERS *****

CREATE TABLE orders AS
SELECT DISTINCT
	`Order ID`,
    `Customer ID`,
    `Order Date`,
	`Ship Date`,
    `Ship Mode`,
    `Product ID`,
    `Sales`,
	`Quantity`,
	`Discount`,
	`Profit` 
FROM superstore_raw; 
-- 13:17:15	CREATE TABLE orders AS SELECT DISTINCT  `Order ID`,     `Customer ID`,     `Order Date`,  `Ship Date`,     `Ship Mode`,     `Product ID`,     `Sales`,  `Quantity`,  `Discount`,  `Profit`  FROM superstore_raw	9693 row(s) affected Records: 9693  Duplicates: 0  Warnings: 0	0.937 sec


-- 3.9 Duplicate orders
SELECT COUNT(*) AS duplicateOrders
FROM (
SELECT `Order ID`
FROM orders
GROUP BY `Order ID`
HAVING COUNT(*) > 1
) t;
-- Order ID is not unique
-- As one order can contains many products

-- 3.10 checking orderId and product id combination 
SELECT `Order ID`,
`Product ID`,
COUNT(*) totalCount
FROM orders
GROUP BY `Order ID`,`Product ID`
HAVING COUNT(*) > 1;


-- Observation:
-- Order ID was found to be non-unique because a single order may contain multiple products.
-- Further investigation showed that even the combination
-- (Order ID, Product ID) was not always unique.
-- Repeated combinations represented valid transaction records
-- with different quantities, sales values and profits.
-- Therefore the orders table was treated as a transactional fact table
-- Therefore no natural primary key exists for the orders table.



-- DATA VALIDATION SUMMARY
-- ==============================================
-- Checks performed  : 12
-- Null values found : 0 (clean dataset)
-- Negative sales    : 0
-- Duplicate Row IDs : 0
-- Orders with loss  : 2749 rows have negative profit
-- Product ID issue  : 30 Product IDs map to multiple names
--                     (documented, PK not enforced)
-- Conclusion        : Dataset is clean for sales analysis.
--                     Product dimension has quality issues
--                     that must be noted in downstream joins.
-- ==============================================



-- -------------------------------------------
-- PART 4 : PERFORM REQUIRED QUERIES
-- -------------------------------------------

-- 1.Find all orders where sales are greater than the average sales. (Subquery)  

SELECT * 
FROM orders
WHERE Sales > (
	SELECT avg(Sales)
    FROM orders
);
-- Identify orders that generated above-average sales.
-- Calculate the average sales value using a subquery and
-- return all orders whose sales exceed the overall average.

-- The inner query runs once and returns a single number: AVG(sales).
-- The outer query then compares each row's sales against that threshold.
-- Avg sales across 9,994 rows = 229.8580

-- OR we can write it like this 
SELECT o.`Order ID`,
c.`Customer Name`,
p.`Product Name`,
p.Category,
ROUND(o.Sales, 2) AS sales,
ROUND(o.Profit, 2) AS profit,
o.`Order Date`
FROM orders o
JOIN customers c ON c.`Customer ID` = o.`Customer ID`
JOIN products p ON p.`Product ID`  = o.`Product ID`
WHERE  o.Sales > (
SELECT AVG(Sales)         -- scalar subquery
FROM   Orders
)
ORDER BY o.Sales DESC;

-- Note:
-- Product table contains Product ID inconsistencies identified during
-- data quality checks. Therefore some joins may return duplicate product
-- descriptions for affected Product IDs.

-- ***** ADDITIONAL INSIGHT *****
SELECT `Order ID`,
`Customer ID`,
Sales,
Quantity,
Profit
FROM orders
WHERE Sales >
(
    SELECT AVG(Sales)
    FROM orders
)
ORDER BY Sales DESC;

-- Insight:
-- Orders returned by this query represent higher-value transactions
-- compared to the overall average order value and may contribute
-- disproportionately to total revenue.



-- 2. Find the highest sales order for each customer. (Subquery)  

-- SELECT c.`Customer Name`,
-- o.`Order ID`,
-- o.Sales,
-- o.Profit
-- FROM orders o
-- JOIN customers c
-- ON c.`Customer ID` = o.`Customer ID`
-- WHERE Sales =
-- (
--     SELECT MAX(o1.Sales)
--     FROM orders o1
--     WHERE o1.`Customer ID` = o.`Customer ID`
-- )
-- ORDER BY Sales DESC
-- LIMIT 10;


-- A correlated subquery was used to calculate the maximum sales value for each customer individually.
-- The outer query compares every order against the customer's highest recorded sale and returns only the top-performing transaction.
-- This approach demonstrates row-level comparison logic and is a classic use case of correlated subqueries in SQL.
-- The analysis helps identify peak purchasing behavior and highlights customers generating high-value transactions.


SELECT *
FROM (
SELECT c.`Customer Name`,
o.`Order ID`,
o.Sales,
o.Profit
FROM orders o
JOIN customers c
ON c.`Customer ID` = o.`Customer ID`) t
WHERE Sales IN (
SELECT MAX(Sales)
FROM orders
GROUP BY `Customer ID`
)
ORDER BY Sales DESC;


-- A subquery was used to first determine the maximum sales value for each customer using GROUP BY aggregation.
-- The outer query then retrieves all orders whose sales match the customer-level maximum sales values.
-- This approach reduces repeated calculations and is generally more efficient than a correlated subquery on larger datasets.
-- The resulting output provides a customer-wise view of the highest-value orders, supporting customer profiling and revenue analysis.


-- Query 1 uses a Correlated Subquery, where the subquery executes for each row in the outer query.
-- Query 2 uses a standalone aggregation subquery, which computes customer-level maximum sales once and then filters matching orders.
-- While both achieve similar results, Query 2 is generally more scalable and performs better on larger datasets.


-- PERFORMANCE NOTE:
-- The correlated subquery (commented above) executes once per
-- customer row — meaning 793 separate inner queries for 793 customers.
-- At scale with millions of customers, this becomes a bottleneck.
-- The standalone aggregation subquery used here computes MAX(Sales)
-- per customer once and filters in a single pass — more efficient.
-- In a production Databricks pipeline, the preferred approach would be
-- DENSE_RANK() OVER (PARTITION BY Customer ID ORDER BY Sales DESC)
-- filtered at rank = 1 — avoiding subqueries entirely.


-- 3. Calculate total sales for each customer. (CTE) 
WITH information AS(
SELECT 
c.`Customer ID`,
c.`Customer Name`,
SUM(s.Sales) totalSales
FROM customers c
JOIN orders s
ON c.`Customer ID` = s.`Customer ID`
GROUP BY `Customer ID`, `Customer Name`
)
SELECT *
FROM information 
ORDER BY totalSales DESC;

-- A CTE was used to first aggregate customer-level sales, creating a reusable and readable intermediate result set.
-- The query combines JOIN, GROUP BY, and SUM() to identify the highest revenue-generating customers.
-- This analysis highlights revenue concentration and helps identify high-value customers for retention and loyalty strategies.

-- The analysis reveals a clear revenue concentration pattern, where a small percentage
-- of customers generate a disproportionately large share of total sales.
-- Sean Miller generated over $25K in sales, making him the most valuable customer
-- in the dataset. The top 10 customers collectively represent a significant revenue segment.


-- 4. Find customers whose total sales are above average. (CTE + Subquery)
WITH information AS(
SELECT 
c.`Customer ID`,
c.`Customer Name`,
ROUND(SUM(s.Sales),2) totalSales
FROM customers c
JOIN orders s
ON c.`Customer ID` = s.`Customer ID`
GROUP BY `Customer ID`, `Customer Name`
)
SELECT `Customer ID`,
`Customer Name`,
totalSales
FROM information
WHERE totalSales > (
SELECT AVG(totalSales)
FROM information
);
-- A CTE was used to calculate total sales for each customer and create a clean intermediate dataset for analysis.
-- A subquery was then used to compute the average customer sales, allowing high-performing customers to be identified relative to the overall customer base.
-- This approach demonstrates customer segmentation using SQL and helps identify customers who contribute above-average revenue to the business.



-- 5. Rank all customers based on total sales. (Window Function)  
WITH information AS(
SELECT 
c.`Customer ID`,
c.`Customer Name`,
ROUND(SUM(s.Sales),2) totalSales
FROM customers c
JOIN orders s
ON c.`Customer ID` = s.`Customer ID`
GROUP BY `Customer ID`, `Customer Name`
)
SELECT *,
DENSE_RANK() OVER(ORDER BY totalSales DESC) customerRank
FROM information;

-- Customer-level sales were aggregated using a CTE to separate business logic from ranking logic, improving query readability and scalability.
-- DENSE_RANK() was chosen over ROW_NUMBER() and RANK() to provide fair and continuous ranking when multiple customers generate the same revenue.
-- Revenue-based customer ranking is a common Business Intelligence technique used to identify high-value customers and optimize retention, loyalty, and growth strategies.

-- WHY DENSE_RANK OVER RANK AND ROW_NUMBER:
-- ROW_NUMBER() — always unique, arbitrary tiebreak for equal sales
-- RANK()       — creates gaps (1,1,3) when ties exist
-- DENSE_RANK() — no gaps (1,1,2), fair ranking for business reporting
-- In a real CRM system, two customers with identical revenue
-- should hold the same rank — DENSE_RANK achieves this correctly.



-- 6. Assign row numbers to each order within a customer. (Window Function + PARTITION BY)  
WITH orderInfo AS(
SELECT 
c.`Customer ID`,
c.`Customer Name`,
o.`Order ID`
FROM customers c
JOIN orders o
ON c.`Customer ID` = o.`Customer ID`
)
SELECT *,
ROW_NUMBER() OVER(PARTITION BY `Customer ID` ORDER BY `Order ID`) 
FROM orderInfo;

-- PARTITION BY was used to create customer-specific partitions, allowing orders to be ranked independently for each customer.
-- ROW_NUMBER() generates a unique sequence for every order, enabling chronological tracking of customer purchasing behavior.
-- Such analysis forms the foundation for advanced use cases including first-order analysis, repeat customer tracking, and customer lifecycle modeling.



-- 7. Display top 3 customers based on total sales. (Window Function)  
SELECT *
FROM
(
SELECT c.`Customer ID`,
c.`Customer Name`,
ROUND(SUM(o.Sales),2) totalSales,
DENSE_RANK() OVER(ORDER BY SUM(o.Sales) DESC) AS position
FROM customers c
JOIN orders o
ON c.`Customer ID` = o.`Customer ID`
GROUP BY c.`Customer ID`,c.`Customer Name`
) info
WHERE position <=3;

-- The query combines aggregation and window functions to transform transactional data into a ranked customer performance report.
-- DENSE_RANK() was preferred over LIMIT-based filtering to correctly handle revenue ties while preserving ranking integrity.
-- Identifying top-performing customers enables businesses to focus on loyalty programs, customer lifetime value optimization, and targeted growth strategies.



-- --------------------------------------------
-- PART 5 : Final Combined Query
-- --------------------------------------------

-- Write one final query that shows: 
-- Customer Name  
-- Total Sales  
-- Rank  
-- (Use JOIN + CTE + Window Function together)

WITH information AS(
SELECT 
c.`Customer ID`,
c.`Customer Name`,
ROUND(SUM(s.Sales),2) totalSales
FROM customers c
JOIN orders s
ON c.`Customer ID` = s.`Customer ID`
GROUP BY `Customer ID`, `Customer Name`
)
SELECT
`Customer Name`,
totalSales,
DENSE_RANK() OVER(ORDER BY totalSales DESC) AS customerRank
FROM information;

-- This query combines JOIN, CTE, and Window Functions to build a complete customer performance report.
-- The JOIN operation integrates customer information with transactional sales data, while the CTE creates
-- a reusable customer-level revenue layer by aggregating total sales for each customer.

-- Why Use a CTE?
-- The CTE separates data preparation from analytical logic, making the query more modular, readable,
-- and easier to extend for future reporting requirements such as customer segmentation or profitability analysis.

-- Window Function Usage:
-- DENSE_RANK() was applied to rank customers based on total sales while correctly handling revenue ties.
-- Unlike LIMIT-based approaches, customers generating identical revenue receive the same rank without gaps,
-- resulting in a more accurate and business-friendly ranking structure.

-- This query integrates JOIN, CTE, and Window Functions to transform raw transactional data into a customer performance report.
-- The CTE creates a reusable customer-level revenue layer, while DENSE_RANK() assigns fair rankings based on total sales.
-- The analysis helps identify high-value customers, understand revenue concentration, and support customer segmentation strategies.
-- Such ranking models are widely used in Business Intelligence and CRM systems for retention planning and customer lifetime value analysis.


-- -----------------------------------------------
-- PART 6 : Mini Project: Customer Sales Insights 
-- -----------------------------------------------


-- 1. Who are the top 5 customers?  
WITH information AS (
SELECT `Customer ID`,
ROUND(SUM(Sales),2) AS totalSales
FROM orders
GROUP BY `Customer ID`
)
SELECT *
FROM (
SELECT *,
DENSE_RANK() OVER(ORDER BY totalSales DESC) AS position
FROM information) t
WHERE position <= 5;


-- The query combines aggregation and window functions to identify the highest revenue-generating customers.
-- DENSE_RANK() provides a fair ranking mechanism by assigning the same rank to customers with identical sales performance.
-- Top-customer analysis is widely used in Business Intelligence to identify strategic customers and optimize loyalty initiatives.
-- Understanding revenue concentration enables businesses to focus resources on customers with the greatest business impact.


-- 2. Who are the bottom 5 customers?
WITH information AS (
SELECT `Customer ID`,
ROUND(SUM(Sales),2) AS totalSales
FROM orders
GROUP BY `Customer ID`
)
SELECT *
FROM (
SELECT *,
DENSE_RANK() OVER(ORDER BY totalSales ASC) AS position
FROM information) t
WHERE position <= 5;

-- A CTE was used to aggregate total sales at the customer level, creating a simplified view of customer revenue contribution.
-- DENSE_RANK() was applied in ascending order to identify customers generating the lowest sales while properly handling ties.
-- Bottom-customer analysis helps uncover low-engagement customers, enabling businesses to design targeted retention and reactivation strategies.
-- Understanding low-performing customer segments can reveal opportunities to improve customer engagement and revenue growth.



-- 3. Which customers made only one order?
SELECT c.`Customer ID`,
c.`Customer Name`,
COUNT(DISTINCT `Order ID`) as cnt 
FROM orders o
JOIN customers c
ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.`Customer ID`, c.`Customer Name`
HAVING cnt = 1;

-- The query identifies one-time buyers by counting the number of distinct orders placed by each customer.
-- Aggregation and HAVING were used together to filter customers whose purchase frequency is exactly one order.
-- One-time customers are important for retention analysis, as they represent users who have not yet developed repeat purchasing behavior.
-- Understanding this segment helps businesses design targeted engagement strategies to improve customer retention and lifetime value.



-- 4. Which customers have above-average sales?  
WITH information AS (
SELECT c.`Customer ID`,
c.`Customer Name`,
ROUND(SUM(o.Sales),2) AS totalSales
FROM customers c
JOIN orders o
ON c.`Customer ID` = o.`Customer ID`
GROUP BY
c.`Customer ID`,
c.`Customer Name`
)
SELECT `Customer ID`,
`Customer Name`,
totalSales
FROM information
WHERE totalSales >
(
SELECT AVG(totalSales)
FROM information
)
ORDER BY totalSales DESC;

-- A CTE was used to aggregate customer-level sales, creating a reusable analytical layer for performance evaluation.
-- A subquery dynamically calculates the average customer revenue and uses it as a benchmark to identify high-performing customers.
-- This approach enables revenue-based customer segmentation by highlighting customers who contribute above-average sales to the business.
-- Such analysis is commonly used in Business Intelligence and CRM systems to identify high-value customers and optimize retention strategies.


-- 5. What is the highest order value per customer? 


-- This also performs the same tast but not efficient for larger datasets

-- SELECT c.`Customer ID`,
-- c.`Customer Name`,
-- o.`Order ID`,
-- o.Sales AS highestValue
-- FROM customers c
-- JOIN orders o
-- ON c.`Customer ID` = o.`Customer ID`
-- WHERE o.Sales =
-- ( SELECT MAX(o2.Sales)
-- FROM orders o2
-- WHERE o2.`Customer ID` = o.`Customer ID`
-- )
-- ORDER BY highestValue DESC;




-- preferred for performance on larger datasets

SELECT c.`Customer ID`,
c.`Customer Name`,
ROUND(MAX(o.Sales),2) AS highestValue
FROM customers c
JOIN orders o
ON c.`Customer ID` = o.`Customer ID`
GROUP BY
c.`Customer ID`,
c.`Customer Name`
ORDER BY highestValue DESC;


-- The query uses aggregation to determine the highest order value recorded for each customer across all transactions.
-- MAX(Sales) helps identify peak purchasing behavior and highlights the most valuable transaction made by every customer.
-- This analysis is useful for understanding customer spending patterns and identifying customers with high purchasing potential.
-- Such insights can support premium customer targeting, personalized marketing campaigns, and customer value analysis.
 
 
 
 
 
