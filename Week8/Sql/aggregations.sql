-- ===========================================================
-- aggregations.sql
-- E-Commerce Order Analytics System
-- Basic & Intermediate SQL Analytics
-- ===========================================================

------------------------------------------------------------
-- 1. Total Revenue Per Customer
------------------------------------------------------------
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price *
        (1 - oi.discount_percent/100.0)),2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

------------------------------------------------------------
-- 2. Total Revenue Per Category
------------------------------------------------------------
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price *
        (1 - oi.discount_percent/100.0)),2) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

------------------------------------------------------------
-- 3. Monthly Revenue Trend
------------------------------------------------------------
SELECT
    strftime('%Y-%m', o.order_date) AS month,
    ROUND(SUM(oi.quantity * oi.unit_price *
        (1 - oi.discount_percent/100.0)),2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

------------------------------------------------------------
-- 4. Top 10 Customers By Order Value
------------------------------------------------------------
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price *
        (1 - oi.discount_percent/100.0)),2) AS order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY order_value DESC
LIMIT 10;

------------------------------------------------------------
-- 5. Top Products By Quantity Sold
------------------------------------------------------------
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.quantity > 0
GROUP BY p.product_id, p.product_name
ORDER BY quantity_sold DESC
LIMIT 10;

------------------------------------------------------------
-- 6. Top Products By Revenue
------------------------------------------------------------
SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.quantity * oi.unit_price *
        (1 - oi.discount_percent/100.0)),2) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 10;

------------------------------------------------------------
-- 7. Average Order Value (AOV) By Customer Type
------------------------------------------------------------
WITH order_totals AS (
SELECT
    o.order_id,
    o.customer_id,
    SUM(oi.quantity * oi.unit_price *
        (1 - oi.discount_percent/100.0)) AS order_total
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id, o.customer_id
)
SELECT
    c.customer_type,
    ROUND(AVG(order_total),2) AS average_order_value
FROM order_totals ot
JOIN customers c
    ON ot.customer_id = c.customer_id
GROUP BY c.customer_type;

------------------------------------------------------------
-- 8. Month-wise Order Count (Last 12 Months)
------------------------------------------------------------
SELECT
    strftime('%Y-%m', order_date) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month DESC
LIMIT 12;

------------------------------------------------------------
-- 9. Customers With No Delivered Orders
------------------------------------------------------------
SELECT DISTINCT
    c.customer_id,
    c.customer_name
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.customer_id NOT IN
(
    SELECT customer_id
    FROM orders
    WHERE status='DELIVERED'
);

------------------------------------------------------------
-- 10. Products Having More Returns Than Purchases
------------------------------------------------------------
SELECT
    p.product_name,
    SUM(CASE WHEN oi.quantity<0 THEN 1 ELSE 0 END) AS returns,
    SUM(CASE WHEN oi.quantity>0 THEN 1 ELSE 0 END) AS purchases
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.product_name
HAVING returns > purchases;

------------------------------------------------------------
-- 11. Return Rate Per Category
------------------------------------------------------------
SELECT
    p.category,
    ROUND(
        100.0 * SUM(CASE WHEN oi.quantity<0 THEN 1 ELSE 0 END)
        / COUNT(*),
    2) AS return_rate_percent
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.category
ORDER BY return_rate_percent DESC;

------------------------------------------------------------
-- END
------------------------------------------------------------
