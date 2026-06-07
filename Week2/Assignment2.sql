CREATE DATABASE bussiness;
-- 19:23:49	CREATE DATABASE bussiness	1 row(s) affected	0.016 sec

USE bussiness;
-- 19:24:18	USE bussiness	0 row(s) affected	0.000 sec

CREATE TABLE customers ( 
    customer_id   INT           PRIMARY KEY, 
    first_name    VARCHAR(50)   NOT NULL, 
    last_name     VARCHAR(50)   NOT NULL, 
    email         VARCHAR(100)  UNIQUE NOT NULL, 
    city          VARCHAR(50)   NOT NULL, 
    state         VARCHAR(50)   NOT NULL, 
    join_date     DATE          NOT NULL, 
    is_premium    BOOLEAN       DEFAULT FALSE 
);
-- 19:26:03	CREATE TABLE customers (      customer_id   INT           PRIMARY KEY,      first_name    VARCHAR(50)   NOT NULL,      last_name     VARCHAR(50)   NOT NULL,      email         VARCHAR(100)  UNIQUE NOT NULL,      city          VARCHAR(50)   NOT NULL,      state         VARCHAR(50)   NOT NULL,      join_date     DATE          NOT NULL,      is_premium    BOOLEAN       DEFAULT FALSE  )	0 row(s) affected	0.125 sec


-- Index for filtering by city/state 
CREATE INDEX idx_customers_city ON customers(city); 
CREATE INDEX idx_customers_state ON customers(state);
-- 19:27:02	CREATE INDEX idx_customers_city ON customers(city)	0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.063 sec
-- 19:27:02	CREATE INDEX idx_customers_state ON customers(state)	0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.046 sec


CREATE TABLE products ( 
    product_id    INT           PRIMARY KEY, 
    product_name  VARCHAR(100)  NOT NULL, 
    category      VARCHAR(50)   NOT NULL, 
    brand         VARCHAR(50)   NOT NULL, 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    stock_qty     INT           NOT NULL  DEFAULT 0  CHECK (stock_qty >= 0) 
); 
-- 19:27:58	CREATE TABLE products (      product_id    INT           PRIMARY KEY,      product_name  VARCHAR(100)  NOT NULL,      category      VARCHAR(50)   NOT NULL,      brand         VARCHAR(50)   NOT NULL,      unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0),      stock_qty     INT           NOT NULL  DEFAULT 0  CHECK (stock_qty >= 0)  )	0 row(s) affected	0.062 sec


-- Index for filtering by category 
CREATE INDEX idx_products_category ON products(category);
-- 19:28:27	CREATE INDEX idx_products_category ON products(category)	0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.063 sec


CREATE TABLE orders ( 
    order_id      INT           PRIMARY KEY, 
    customer_id   INT           NOT NULL, 
    order_date    DATE          NOT NULL, 
    status        VARCHAR(20)   NOT NULL  DEFAULT 'Pending' 
                  CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')), 
    total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0), 
     
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);
-- 19:29:38	CREATE TABLE orders (      order_id      INT           PRIMARY KEY,      customer_id   INT           NOT NULL,      order_date    DATE          NOT NULL,      status        VARCHAR(20)   NOT NULL  DEFAULT 'Pending'                    CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')),      total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0),            FOREIGN KEY (customer_id) REFERENCES customers(customer_id)  )	0 row(s) affected	0.156 sec


-- Index for date-based filtering and sorting 
CREATE INDEX idx_orders_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status);
-- 19:30:14	CREATE INDEX idx_orders_date ON orders(order_date)	0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.078 sec
-- 19:30:14	CREATE INDEX idx_orders_status ON orders(status)	0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.047 sec


CREATE TABLE order_items ( 
    item_id       INT           PRIMARY KEY, 
    order_id      INT           NOT NULL, 
    product_id    INT           NOT NULL, 
    quantity      INT           NOT NULL  CHECK (quantity > 0), 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    discount_pct  DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100), 
     
    FOREIGN KEY (order_id)   REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
); 
-- 19:30:51	CREATE TABLE order_items (      item_id       INT           PRIMARY KEY,      order_id      INT           NOT NULL,      product_id    INT           NOT NULL,      quantity      INT           NOT NULL  CHECK (quantity > 0),      unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0),      discount_pct  DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100),            FOREIGN KEY (order_id)   REFERENCES orders(order_id),      FOREIGN KEY (product_id) REFERENCES products(product_id)  )	0 row(s) affected	0.156 sec



-- ========== INSERT: customers ========== 
INSERT INTO customers VALUES 
(101, 'Aarav',  'Sharma', 'aarav.s@email.com',  'Mumbai',    'Maharashtra', '2024-01-15', TRUE), 
(102, 'Priya',  'Patel',  'priya.p@email.com',  'Ahmedabad', 'Gujarat',     '2024-02-20', FALSE), 
(103, 'Rohan',  'Gupta',  'rohan.g@email.com',  'Delhi',     'Delhi',       '2024-03-10', TRUE), 
(104, 'Sneha',  'Reddy',  'sneha.r@email.com',  'Hyderabad', 'Telangana',   '2024-04-05', FALSE), 
(105, 'Vikram', 'Singh',  'vikram.s@email.com', 'Jaipur',    'Rajasthan',   '2024-05-12', TRUE), 
(106, 'Ananya', 'Iyer',   'ananya.i@email.com', 'Chennai',   'Tamil Nadu',  '2024-06-18', FALSE), 
(107, 'Karan',  'Mehta',  'karan.m@email.com',  'Pune',      'Maharashtra', '2024-07-22', TRUE), 
(108, 'Divya',  'Nair',   'divya.n@email.com',  'Kochi',     'Kerala',      '2024-08-30', FALSE); 
-- 20:00:21	INSERT INTO customers VALUES  (101, 'Aarav',  'Sharma', 'aarav.s@email.com',  'Mumbai',    'Maharashtra', '2024-01-15', TRUE),  (102, 'Priya',  'Patel',  'priya.p@email.com',  'Ahmedabad', 'Gujarat',     '2024-02-20', FALSE),  (103, 'Rohan',  'Gupta',  'rohan.g@email.com',  'Delhi',     'Delhi',       '2024-03-10', TRUE),  (104, 'Sneha',  'Reddy',  'sneha.r@email.com',  'Hyderabad', 'Telangana',   '2024-04-05', FALSE),  (105, 'Vikram', 'Singh',  'vikram.s@email.com', 'Jaipur',    'Rajasthan',   '2024-05-12', TRUE),  (106, 'Ananya', 'Iyer',   'ananya.i@email.com', 'Chennai',   'Tamil Nadu',  '2024-06-18', FALSE),  (107, 'Karan',  'Mehta',  'karan.m@email.com',  'Pune',      'Maharashtra', '2024-07-22', TRUE),  (108, 'Divya',  'Nair',   'divya.n@email.com',  'Kochi',     'Kerala',      '2024-08-30', FALSE)	8 row(s) affected Records: 8  Duplicates: 0  Warnings: 0	0.000 sec



-- ========== INSERT: products ========== 
INSERT INTO products VALUES 
(201, 'Wireless Earbuds',     'Electronics', 'BoAt',          1499.00, 250), 
(202, 'Cotton T-Shirt',       'Clothing',    'Levis',         799.00,  500), 
(203, 'Smart Watch',          'Electronics', 'Noise',         2999.00, 150), 
(204, 'Running Shoes',        'Clothing',    'Nike',          4599.00, 120), 
(205, 'Bluetooth Speaker',    'Electronics', 'JBL',           3499.00, 200), 
(206, 'Bedsheet Set',         'Home',        'Spaces',        1299.00, 300), 
(207, 'Laptop Stand',         'Electronics', 'AmazonBasics',  899.00,  180), 
(208, 'Cushion Covers (Set)', 'Home',        'HomeCenter',    599.00,  400); 
-- 20:00:59	INSERT INTO products VALUES  (201, 'Wireless Earbuds',     'Electronics', 'BoAt',          1499.00, 250),  (202, 'Cotton T-Shirt',       'Clothing',    'Levis',         799.00,  500),  (203, 'Smart Watch',          'Electronics', 'Noise',         2999.00, 150),  (204, 'Running Shoes',        'Clothing',    'Nike',          4599.00, 120),  (205, 'Bluetooth Speaker',    'Electronics', 'JBL',           3499.00, 200),  (206, 'Bedsheet Set',         'Home',        'Spaces',        1299.00, 300),  (207, 'Laptop Stand',         'Electronics', 'AmazonBasics',  899.00,  180),  (208, 'Cushion Covers (Set)', 'Home',        'HomeCenter',    599.00,  400)	8 row(s) affected Records: 8  Duplicates: 0  Warnings: 0	0.015 sec



-- ========== INSERT: orders ========== 
INSERT INTO orders VALUES 
(1001, 101, '2024-08-01', 'Delivered',  4498.00), 
(1002, 102, '2024-08-03', 'Delivered',  799.00), 
(1003, 103, '2024-08-05', 'Shipped',    7498.00), 
(1004, 101, '2024-08-10', 'Delivered',  3499.00), 
(1005, 104, '2024-08-12', 'Cancelled',  2999.00), 
(1006, 105, '2024-08-15', 'Delivered',  5898.00), 
(1007, 106, '2024-08-18', 'Pending',    1299.00), 
(1008, 103, '2024-08-20', 'Delivered',  899.00), 
(1009, 107, '2024-08-25', 'Shipped',    6098.00), 
(1010, 108, '2024-08-28', 'Delivered',  1598.00); 
-- 20:01:23	INSERT INTO orders VALUES  (1001, 101, '2024-08-01', 'Delivered',  4498.00),  (1002, 102, '2024-08-03', 'Delivered',  799.00),  (1003, 103, '2024-08-05', 'Shipped',    7498.00),  (1004, 101, '2024-08-10', 'Delivered',  3499.00),  (1005, 104, '2024-08-12', 'Cancelled',  2999.00),  (1006, 105, '2024-08-15', 'Delivered',  5898.00),  (1007, 106, '2024-08-18', 'Pending',    1299.00),  (1008, 103, '2024-08-20', 'Delivered',  899.00),  (1009, 107, '2024-08-25', 'Shipped',    6098.00),  (1010, 108, '2024-08-28', 'Delivered',  1598.00)	10 row(s) affected Records: 10  Duplicates: 0  Warnings: 0	0.016 sec



-- ========== INSERT: order_items ========== 
INSERT INTO order_items VALUES 
(5001, 1001, 201, 2, 1499.00, 0), 
(5002, 1001, 207, 1, 899.00,  10), 
(5003, 1002, 202, 1, 799.00,  0), 
(5004, 1003, 203, 1, 2999.00, 0), 
(5005, 1003, 204, 1, 4599.00, 5), 
(5006, 1004, 205, 1, 3499.00, 0), 
(5007, 1005, 203, 1, 2999.00, 0), 
(5008, 1006, 201, 1, 1499.00, 10), 
(5009, 1006, 204, 1, 4599.00, 5), 
(5010, 1007, 206, 1, 1299.00, 0), 
(5011, 1008, 207, 1, 899.00,  0), 
(5012, 1009, 205, 1, 3499.00, 0), 
(5013, 1009, 208, 2, 599.00,  15), 
(5014, 1010, 206, 1, 1299.00, 0), 
(5015, 1010, 208, 1, 599.00,  0); 
-- 20:02:07	INSERT INTO order_items VALUES  (5001, 1001, 201, 2, 1499.00, 0),  (5002, 1001, 207, 1, 899.00,  10),  (5003, 1002, 202, 1, 799.00,  0),  (5004, 1003, 203, 1, 2999.00, 0),  (5005, 1003, 204, 1, 4599.00, 5),  (5006, 1004, 205, 1, 3499.00, 0),  (5007, 1005, 203, 1, 2999.00, 0),  (5008, 1006, 201, 1, 1499.00, 10),  (5009, 1006, 204, 1, 4599.00, 5),  (5010, 1007, 206, 1, 1299.00, 0),  (5011, 1008, 207, 1, 899.00,  0),  (5012, 1009, 205, 1, 3499.00, 0),  (5013, 1009, 208, 2, 599.00,  15),  (5014, 1010, 206, 1, 1299.00, 0),  (5015, 1010, 208, 1, 599.00,  0)	15 row(s) affected Records: 15  Duplicates: 0  Warnings: 0	0.000 sec


-- -------------------------------------------------------------
-- SECTION A :— SQL Basics (SELECT, Constraints, Primary Keys)
-- -------------------------------------------------------------

-- Q1. Write a query to display all columns and rows from the customer's table.
SELECT * 
FROM customers;

-- Q2. Retrieve only the first_name, last_name, and city of all customers. 
SELECT first_name,
last_name,
city
FROM customers;

-- Q3. List all unique categories available in the products table.
SELECT DISTINCT category 
FROM products;

-- DISTINCT removes duplicate values and returns
-- only unique product categories.

-- Q4. Identify the Primary Key of each table in the schema. Explain why a Primary Key must be unique and NOT NULL.
--    Table        Primary Key    DataType
--  customers      customer_id      INT
--  products       product_id       INT
--  orders         order_id         INT
--  order_items    item_id          INT

-- A Primary Key is a column (or set of columns) that uniquely identifies each record in a table. It ensures that every row can be distinguished from all other rows.

-- A Primary Key must satisfy the following properties:

-- ==UNIQUE
-- No two rows can have the same Primary Key value.
-- This prevents duplicate records and ensures that each row has a distinct identity.
-- Example: If two customers have the same customer_id, the database would not be able to determine which customer a record refers to.
-- ==NOT NULL
-- A Primary Key cannot contain NULL values.
-- Since the Primary Key is used to identify a record, every row must have a valid identifier.
-- If a Primary Key were NULL, the database would be unable to uniquely identify that row.

-- ==Importance of Primary Keys==:
-- Maintain data integrity.
-- Prevent duplicate records.
-- Support relationships between tables through Foreign Keys.
-- Improve query performance when searching for specific records.


-- Q5. What constraints are applied to the email column in the customers table?
--     What would happen if you tried to insert a duplicate email? 

--    SCHEMA : email VARCHAR(50) UNIQUE NOT NULL
--    CONSTRAINTS : 
--     (i)  UNIQUE : No two customers can share the same email address
--     (ii) NOT NULL : Every customer must provide an email — it cannot be left empty

--     IF WE TRY TO INSERT AN DUPLICATE EMAIL THEN: 
INSERT INTO customers
VALUES (
100,
'Kashish',
'Soni',
'priya.p@email.com',
'Sarwar',
'Rajasthan',
'2026-06-06',
FALSE
);

-- We will get an error : 
-- 21:19:37	INSERT INTO customers VALUES ( 100, 'Kashish', 'Soni', 'priya.p@email.com', 'Sarwar', 'Rajasthan', '2026-06-06', FALSE )
-- Error Code: 1062. Duplicate entry 'priya.p@email.com' for key 'customers.email'	0.015 sec


-- Q6. Try inserting a product with unit_price = -50. 
-- What happens and which constraint prevents it? Write both the INSERT statement and explain the error. 

INSERT INTO products VALUES(200,'Soap','Home','MamaEarth',-50.00,100);
-- When we insert the unit_price = -50 it voilates the condition we have specified, and we will get an error:
-- Error Code: 3819. Check constraint 'products_chk_1' is violated.	0.000 sec.
-- As there is a check in schema which says should be greater than 0.

-- When unit_price = -50 is inserted,
-- it violates the CHECK constraint defined on the column.

-- SCHEMA : unit_price DECIMAL(10,2) NOT NULL CHECK(unit_price>0)
-- Zero-priced products are also rejected. 
-- A product priced at ₹0 would be a data entry error in a commercial system — it would appear as "free" to customers and corrupt revenue calculations. 
-- The schema designer intentionally set > 0 (strictly positive), not >= 0.

-- The correct query will be:
INSERT INTO products VALUES(200,'Soap','Home','MamaEarth',50.00,100);

-- -----------------------------------------------------
-- Section B — Filtering & Optimization (WHERE, Indexes) 
-- -----------------------------------------------------

-- Q7. Retrieve all orders with status = 'Delivered'. 
SELECT * 
FROM orders
WHERE status = 'Delivered';

-- Retrieves all orders whose status is Delivered.

-- Q8. Find all products in the 'Electronics' category with a unit_price greater than ₹2000. 
Select * 
FROM products 
WHERE category = 'Electronics' AND unit_price > 2000;


-- Q9. List all customers who joined in the year 2024 and belong to the state 'Maharashtra'. 
SELECT *
FROM customers 
WHERE join_date >= '2024-01-01'
AND join_date < '2025-01-01'
AND state = 'Maharashtra';

-- NOTE: Using date range instead of YEAR() function
-- Reason: YEAR(join_date) bypasses index — not SARGable
-- Date range directly uses idx on join_date — faster!


-- Q10. Find all orders placed between '2024-08-10' and '2024-08-25' (inclusive) that are NOT cancelled.

-- BETWEEN is inclusive on both ends
-- 2024-08-10 and 2024-08-25 both are included

SELECT *
FROM orders
WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25'
AND status <> 'Cancelled';


-- Q11. Explain what the index idx_orders_date does. 
-- How would it improve the performance of a query that filters orders by order_date? 
-- Write a sample query that would benefit from this index.

-- ==SOLUTION== :
-- INDEX CREATED IN SCHEMA:
-- CREATE INDEX idx_orders_date ON orders(order_date);

-- WHAT IT DOES:
-- Without Index: Full Table Scan
--   → Database reads EVERY row one by one
--   → Fast in 10 rows, SLOW in 10 millions
--   → O(n) time complexity

-- With Index: B-Tree Search
--   → Database directly jumps to matching dates
--   → Fast in 10 million data
--   → O(log n) time complexity

-- Real impact example:
-- Finding Orders of 2024 from 10 million of rows(Orders)
-- Without index: 10 million rows scan
-- With index: directly jump to August dates


-- SAMPLE QUERY THAT BENEFITS FROM THIS INDEX:
SELECT *
FROM orders
WHERE order_date BETWEEN '2024-08-01' AND '2024-08-31';


-- Q12. If you run: SELECT * FROM customers WHERE YEAR(join_date) = 2024; — would the index on join_date be used? 
-- Explain why or why not, and rewrite the query to be index-friendly (SARGable).

-- No, the index would NOT be used.

-- WHY?
-- When we wrap a column inside a function like YEAR(join_date),
-- MySQL cannot use the index directly.
-- 
-- The database has to first open every single row,
-- apply the YEAR() function to extract the year,
-- and then compare it to 2024.
-- 
-- This means MySQL reads the entire table row by row —
-- which is called a Full Table Scan.
-- The index on join_date becomes completely useless here,
-- because the index stores raw date values like '2024-01-15',
-- not extracted year values like 2024.

-- ORIGINAL QUERY (Index NOT used):
SELECT * FROM customers 
WHERE YEAR(join_date) = 2024;


-- HOW TO FIX IT — SARGable Rewrite:
-- 
-- SARGable stands for Search ARGument ABLE.
-- It simply means: write the query in a way that
-- the database CAN use the index.
-- 
-- Instead of extracting the year from the column,
-- we give the database a date range to search within.
-- This way, the column stays untouched,
-- and MySQL can directly scan the index
-- from '2024-01-01' to just before '2025-01-01'.

-- REWRITTEN QUERY:
SELECT * FROM customers
WHERE join_date >= '2024-01-01'
AND join_date < '2025-01-01';


-- PROOF using EXPLAIN:

-- Bad query — Full Table Scan:
EXPLAIN SELECT * FROM customers 
WHERE YEAR(join_date) = 2024;
-- Result → type: ALL
-- This means MySQL read every row. No index used. 

-- Good query — Index Scan:
EXPLAIN SELECT * FROM customers
WHERE join_date >= '2024-01-01'
AND join_date < '2025-01-01';
-- Result → type: range
-- This means MySQL used the index efficiently. 

-- The moment we put a function around a column,
-- the index on that column stops working.
-- Always keep the column clean on one side
-- and put the logic on the value side.
--
-- Does NOT use index:
--   YEAR(join_date) = 2024
--   UPPER(email) = 'TEST@EMAIL.COM'
--   LENGTH(city) > 5
--
-- Uses index correctly:
--   join_date >= '2024-01-01'
--   email = 'test@email.com'
--   city = 'Mumbai'

-- --------------------------------------------------------------------
--  Section C — Aggregation (GROUP BY, SUM, COUNT, AVG, MIN, MAX) 
-- --------------------------------------------------------------------


-- Q13. Count the total number of orders in the orders table. 

-- Method 1: 
-- COUNT(*) counts all rows including every status.
-- We used an alias 'total_orders' to make the output readable.
-- Result: 10
SELECT COUNT(*) AS Total_orders
FROM orders;

-- Method 2: 
-- As the COUNT(*) gives all the rows 
-- We can use the table's PRIMARY KEY which gives us all and UNIQUE Orders
SELECT COUNT(order_id) AS Total_orders
FROM orders;


-- Q14. Find the total revenue (SUM of total_amount) from all 'Delivered' orders.

-- We filter only Delivered orders first using WHERE,
-- then SUM adds up all their total_amount values.
-- Cancelled and Pending orders are excluded intentionally —
-- they should not count as earned revenue.

SELECT SUM(total_amount) AS Total_revenue
FROM orders
WHERE status = 'Delivered';


-- Q15. Calculate the average unit_price of products in each category. 

SELECT category,
ROUND(AVG(unit_price),2) AS Average_price
FROM products
GROUP BY category
ORDER BY Average_price DESC;

-- GROUP BY splits the products into category groups.
-- AVG calculates the average price within each group.
-- ROUND keeps the output clean to 2 decimal places.
-- ORDER BY shows the most expensive category first.


-- Q16. For each order status, find the count of orders and the total revenue.
-- Sort the result by total revenue in descending order. 

SELECT status,
COUNT(*) AS order_count,
SUM(total_amount) AS total_revenue
FROM orders
GROUP BY status
ORDER BY total_revenue DESC;


-- **** ADDITIONAL INSIGHTS ****
-- ROUND(AVG(total_amount), 2) AS avg_order_value


-- Each status gets its own group.
-- COUNT gives how many orders are in that status.
-- SUM gives the total revenue for that status.
-- We can also added AVG as a bonus column — it shows
-- the average order value per status, which gives
-- a more complete picture for business decisions.

-- Interesting observation:
-- Shipped orders have a higher average (6798)
-- than Delivered orders (2865).
-- This means high-value orders are still in transit —
-- worth monitoring from a business perspective.


-- Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category. 
SELECT 
    category,
    MAX(unit_price) AS most_expensive,
    MIN(unit_price) AS cheapest,
    MAX(unit_price) - MIN(unit_price) AS price_range
FROM products
GROUP BY category
ORDER BY most_expensive DESC;

-- MAX and MIN work within each GROUP BY group.
-- I added price_range as a bonus column —
-- it shows how wide the price spread is per category.
-- A large price_range means the category has both
-- budget and premium options available.
-- Clothing has the highest price variation (3800),
-- meaning it serves the widest range of customers.


-- Q18. List all product categories where the average unit_price is greater than ₹2000. 
-- (Hint: Use HAVING clause) 

SELECT category,
ROUND(AVG(unit_price), 2) AS avg_price,
COUNT(*) AS product_count
FROM products
GROUP BY category
HAVING AVG(unit_price) > 2000
ORDER BY avg_price DESC;

-- WHY HAVING and not WHERE?

-- WHERE filters individual rows — it runs BEFORE
-- the data is grouped. We cannot use aggregate
-- functions like AVG() inside WHERE.

-- HAVING filters groups — it runs AFTER GROUP BY.
-- So it can work with AVG(), SUM(), COUNT() etc.

-- If we wrote: WHERE AVG(unit_price) > 2000
-- MySQL would throw an error.
-- HAVING is the correct place for this condition


-- WHERE vs HAVING:

-- WHERE  → filters rows → runs BEFORE GROUP BY
--          cannot use aggregate functions
--          Example: WHERE status = 'Delivered'

-- HAVING → filters groups → runs AFTER GROUP BY
--          can use aggregate functions
--          Example: HAVING AVG(unit_price) > 2000

-- Wrong (gives error):
-- SELECT category, AVG(unit_price)
-- FROM products
-- WHERE AVG(unit_price) > 2000   = ERROR
-- GROUP BY category;

-- Correct:
-- SELECT category, AVG(unit_price)
-- FROM products
-- GROUP BY category
-- HAVING AVG(unit_price) > 2000; 


-- =====================================
--   Section D — Joins & Relationships 
-- =====================================

-- Q19. Write an INNER JOIN query to display each order along with the customer's first_name and last_name. 
-- Show: order_id, order_date, first_name, last_name, total_amount. 

SELECT o.order_id,
o.order_date,
c.first_name,
c.last_name,
o.total_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

-- An INNER JOIN returns only those records that have matching values in both tables.
-- In this query:
-- orders table provides order information.
-- customers table provides customer details.
-- The join is performed using customer_id.
-- Only orders linked to valid customers will appear in the result.
-- Business Insight:
-- This query can be used to generate customer purchase reports and track order history by customer.

-- IMPORTANT: Aarav Sharma appears twice (orders 1001, 1004)
-- This is correct — one customer can place multiple orders.
-- INNER JOIN does not remove duplicates — it matches rows


-- Q20. Using a LEFT JOIN, list ALL customers and their orders (if any). 
-- Customers with no orders should still appear with NULL values for order columns. 

SELECT 
c.customer_id,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
c.city,
c.state,
CASE WHEN c.is_premium = 1 
	THEN 'Premium' 
	ELSE 'Regular' 
END  AS customer_type,
o.order_id,
o.order_date,
o.status,
o.total_amount
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;

-- The question asks for ALL customers — even those
-- who have never placed an order.
-- LEFT JOIN guarantees every customer appears
-- at least once, with NULL in order columns
-- if they have no orders.

-- In this sample data, all 8 customers have orders.
-- But in real production data, new customers who
-- just registered but haven't ordered yet would
-- appear with NULL values like this:
-- customer_id      name        order_id   total_amount
--  109           New User        NULL       NULL

-- I added customer_type using CASE to show
-- whether each customer is Premium or Regular —
-- this gives business context beyond what
-- the question asked for.

-- Business use case:
-- This query is useful for monthly activity reports —
-- identifying customers who registered but
-- never purchased (churned before first order).

-- Q21. Write a query using JOINs across three tables (orders → order_items → products) 
-- to show: order_id, product_name, quantity, unit_price, and discount_pct for each order item. 

SELECT 
o.order_id,
p.product_name,
oi.quantity,
oi.unit_price,
oi.discount_pct
FROM orders o
INNER JOIN order_items AS oi
	ON o.order_id = oi.order_id
INNER JOIN products AS p
	ON oi.product_id = p.product_id;

-- This query joins the orders, order_items, and products tables to display product-level details for each order. 
-- The join is performed using the foreign key relationships between the tables.

-- INNER JOIN is used because we only want records that have matching entries in all three tables.
-- Since an order item must belong to a valid order and reference a valid product, unmatched rows are not useful for sales analysis and are therefore excluded.
-- The join is performed using the foreign key relationships:
-- orders.order_id = order_items.order_id
-- products.product_id = order_items.product_id


-- ******** ADDITIONAL ANALYSIS ***********
SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.product_name,
    p.category,
    oi.quantity,
    oi.unit_price,
    oi.discount_pct,
    ROUND(
        oi.unit_price * oi.quantity,2
    ) AS gross_amount,
    
    ROUND(
        oi.unit_price * oi.quantity *
        (1 - oi.discount_pct / 100),
        2) AS net_amount,
        
    ROUND( oi.unit_price * oi.quantity *
        (oi.discount_pct / 100),2
) AS discount_saved
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN customers c
    ON o.customer_id = c.customer_id

ORDER BY o.order_id, net_amount DESC;

-- Why I Extended the Query:
-- Although the question requires joining three tables, I additionally joined the customers table to include customer information and derive business-focused metrics.

-- Additional Metrics:
-- gross_amount = quantity × unit_price (before discount)
-- net_amount = final amount paid after discount
-- discount_saved = amount saved by the customer

-- Business Significance:
-- This enhanced version resembles a real-world e-commerce sales report and can be used to:
-- Analyze customer purchasing behavior
-- Measure the impact of discounts
-- Track product-level revenue
-- Support sales and pricing decisions


-- Q22. Explain the difference between LEFT JOIN and RIGHT JOIN with an example from this schema. 
-- When would you use a FULL OUTER JOIN? 

-- LEFT JOIN
-- A LEFT JOIN returns all records from the left table and matching records from the right table. 
-- If no match exists, NULL values are returned for the right table columns.

SELECT c.customer_id,
c.first_name,
o.order_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;

-- The order of table matters.
-- All customers will appear.
-- Customers with no orders will still appear.
-- Row multiplication still happens
-- This helps in (i) Recombine data    (ii) Data Enrichment
-- The reason for returning the NULL is that SQL thinks the data is missing but it is UNKNOWN at this time
-- And UNKNOWN is represented as NULL.


-- RIGHT JOIN
-- A RIGHT JOIN returns all records from the right table and matching records from the left table. 
-- If no match exists, NULL values are returned for the left table columns.

SELECT c.customer_id,
c.first_name,
o.order_id
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;
    
-- The order of data is important
-- By swapping the table positions we can get the same result as LEFT JOIN using the RIGHT JOIN
-- All orders will appear.
-- Orders without matching customers would still appear.
-- Customer columns would contain NULL values.

-- Key Difference :
--       LEFT JOIN	                           RIGHT JOIN
-- Keeps all rows from customers	   Keeps all rows from orders
-- Focus is on customers	           Focus is on orders
-- Unmatched orders become NULL	       Unmatched customers become NULL

-- In the current schema, orders.customer_id is a Foreign Key referencing customers.customer_id.
-- Therefore, every order must belong to a valid customer. 
-- As a result, the RIGHT JOIN and INNER JOIN will produce the same result set for the current database.

-- FULL OUTER JOIN
-- A FULL OUTER JOIN returns all rows from both tables.
-- If matching records exist, they are combined into a single row.
-- If no match is found, NULL values are returned for the missing side.

-- When to use: 
-- FULL OUTER JOIN is used when we want to identify records that exist in
-- one dataset but are missing from another dataset. 
-- It is commonly used in data migration, data reconciliation, auditing, and validation tasks

-- Note: The order of tables does not matter in a FULL OUTER JOIN.
-- Since MySQL does not support FULL OUTER JOIN directly, 
-- it can be simulated using a combination of LEFT JOIN and RIGHT JOIN with UNION.

-- MySQL does not support FULL OUTER JOIN directly.
-- Simulating FULL OUTER JOIN using LEFT JOIN + RIGHT JOIN + UNION

-- All customers and all orders even if there is no match:
SELECT c.customer_id,
CONCAT(c.first_name,' ',c.last_name) AS customer_name,
o.order_id,
o.order_date,
o.total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id

UNION

SELECT c.customer_id,
CONCAT(c.first_name,' ',c.last_name) AS customer_name,
o.order_id,
o.order_date,
o.total_amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- Use Case:
-- FULL OUTER JOIN is useful for data validation and reconciliation, 
-- where we need to identify records that exist in one table but not in the other.


-- Q23. Identify all Foreign Key relationships in the schema. 
-- Explain what would happen if you tried to insert an order with customer_id = 999 (which doesn't exist in customers).

-- There are 3 foreign keys:
-- 1. orders.customer_id → customers.customer_id
-- Ensures every order belongs to a valid customer.
-- 2. order_items.order_id → orders.order_id
-- Ensures every order item belongs to an existing order.
-- 3. order_items.product_id → products.product_id
-- Ensures every order item references a valid product.


INSERT INTO orders VALUES (1011,999,'2026-07-06','Delivered',100.00);
-- This gives an error with: 
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
-- (`bussiness`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))	0.031 sec

-- The Foreign Key constraint checks whether the referenced customer exists before allowing the insert. 
-- Since no matching customer record is found, MySQL rejects the operation.
-- Foreign Keys maintain **referential integrity** and prevent invalid or orphan records. 
-- Without this constraint, orders could exist without corresponding customers, leading to incorrect reports, failed joins, and inconsistent business data


-- ---------------------------------------------------------
-- Section E — Advanced Concepts (CASE, ACID, Transactions) 
-- ---------------------------------------------------------

-- Q24. Write a query using CASE to classify products into price tiers: 
--   • 'Budget'    → unit_price < 1000 
--   • 'Mid-Range' → unit_price BETWEEN 1000 AND 3000 
--   • 'Premium'   → unit_price > 3000 
-- Display: product_name, unit_price, price_tier. 

SELECT product_name,
unit_price,
CASE
	WHEN unit_price < 1000 THEN 'Budget'
    WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
    ELSE 'Premium'
END AS price_tier
FROM products
ORDER BY unit_price;

-- CASE works like if-else in programming.
-- Each row is evaluated against the conditions
-- top to bottom — first match wins.
-- ORDER BY unit_price shows the tiers clearly
-- from cheapest to most expensive.

-- Price segmentation helps businesses understand their product portfolio and target different customer groups:
-- Budget → Price-sensitive customers
-- Mid-Range → Value-focused customers
-- Premium → High-end customers


-- Q25. Using a CASE statement inside an aggregate function, 
-- count how many orders are 'Delivered' vs 'Not Delivered' (all other statuses).
--  Display the result in a single row. 

SELECT 
	SUM(CASE WHEN status = 'Delivered'
			 THEN 1 ELSE 0 END ) As Delivered_orders,
	SUM(CASE WHEN status <> 'Delivered'
			 THEN 1 ELSE 0 END ) As Not_delivered_orders
FROM orders;

-- HOW CASE INSIDE SUM WORKS:
-- For each row, CASE checks the condition.
-- If true  → returns 1 (counted)
-- If false → returns 0 (not counted)
-- SUM adds all the 1s = total matching rows
-- This technique is called Conditional Aggregation.
-- It lets us count multiple categories
-- in a single query without multiple subqueries.


-- ****** Additional Insight *********
SELECT
    SUM(CASE WHEN status = 'Delivered'
             THEN 1 ELSE 0 END) AS delivered_orders,
    SUM(CASE WHEN status <> 'Delivered'
             THEN 1 ELSE 0 END) AS not_delivered_orders,
    COUNT(*) AS total_orders,
    CONCAT(
        ROUND(
            SUM(CASE WHEN status = 'Delivered'
                     THEN 1 ELSE 0 END) * 100.0
            / COUNT(*), 1
        ),
        '%'
    ) AS delivery_success_rate
FROM orders;

-- delivery_success_rate is a bonus column —
-- it shows 60% of orders are delivered,
-- which is a real business KPI (Key Performance Indicator)

-- Q26. Explain each letter of ACID: 
--  • A – Atomicity 
--  • C – Consistency 
--  • I – Isolation 
--  • D – Durability 
-- Give a real-world example (e.g., bank transfer) showing why each property is important. 



-- ACID is a set of four properties that ensure
-- database transactions are processed reliably.

-- A — ATOMICITY
-- "All or Nothing"

-- A transaction is treated as a single unit.
-- Either all operations succeed or all are rolled back.

-- Example:
-- When a customer places an order,
-- a new order is created and product stock is reduced.
-- If the stock update fails, the entire transaction is rolled back
-- so that no partial changes remain in the database.

-- C — CONSISTENCY

-- A transaction must take the database
-- from one valid state to another valid state.
-- All constraints and rules must remain satisfied.

-- Example:
-- If stock_qty cannot be negative,
-- the database will reject any transaction
-- that would make stock_qty less than zero.

-- I — ISOLATION

-- Concurrent transactions should not interfere
-- with each other.
-- Each transaction behaves as if it is running alone.

-- Example:
-- If two customers try to purchase the last item
-- at the same time, Isolation ensures that both
-- transactions do not update the stock incorrectly.

-- D — DURABILITY

-- Once a transaction is committed,
-- it is permanently stored in the database.
-- The data remains available even after a system failure.

-- Example:
-- If a customer completes payment and the transaction
-- is committed, the order information remains saved
-- even if the server crashes immediately afterward.

-- ACID Quick Summary

-- A → Atomicity  = All or Nothing
-- C → Consistency = Valid state to valid state
-- I → Isolation   = Transactions do not interfere
-- D → Durability  = Committed data is permanent



-- Q27. Write a SQL transaction that does the following atomically: 
--   1. Insert a new order (order_id=1011, customer_id=102, today's date, 'Pending', 1598.00) 
--   2. Insert two order items for that order 
--   3. Update the stock_qty of the purchased products 
--   4. If any step fails, ROLLBACK the entire transaction. Otherwise, COMMIT. 
-- Write the complete BEGIN...COMMIT/ROLLBACK block. 


-- Q27. Transaction (Successful Execution)

-- FOR COMMIT:

START TRANSACTION;

INSERT INTO orders
(order_id, customer_id, order_date, status, total_amount)
VALUES
(1011, 102, CURDATE(), 'Pending', 1598.00);

INSERT INTO order_items
(item_id, order_id, product_id, quantity, unit_price, discount_pct)
VALUES
(5016, 1011, 206, 1, 1299.00, 0);

INSERT INTO order_items
(item_id, order_id, product_id, quantity, unit_price, discount_pct)
VALUES
(5017, 1011, 208, 1, 299.00, 0);

UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 206;

UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 208;

COMMIT;

-- For Rollback:
-- Transaction Failure Example

START TRANSACTION;

INSERT INTO orders
(order_id, customer_id, order_date, status, total_amount)
VALUES
(1012, 102, CURDATE(), 'Pending', 1598.00);

-- Invalid product_id (does not exist)
INSERT INTO order_items
(item_id, order_id, product_id, quantity, unit_price, discount_pct)
VALUES
(5018, 1012, 999, 1, 1299.00, 0);

ROLLBACK;


-- If all statements execute successfully, COMMIT saves the changes permanently.
-- If any statement fails, ROLLBACK cancels the entire transaction,
-- ensuring that no partial changes are stored in the database.

-- ROLLBACK works inside PROCEDURES — not FUNCTIONS.
-- Functions are designed to calculate and return
-- a single value — like a calculator.
-- Procedures are designed to perform actions —
-- insert, update, delete, manage transactions.
-- So ROLLBACK belongs in procedures, not functions.














