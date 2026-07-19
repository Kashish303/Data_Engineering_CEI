-- ===========================================================
-- window_functions.sql
-- Advanced Window Function Queries
-- E-Commerce Order Analytics System
-- ===========================================================

------------------------------------------------------------
-- 1. ROW_NUMBER - Orders per Customer
------------------------------------------------------------
SELECT
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_sequence
FROM orders;

------------------------------------------------------------
-- 2. RANK - Customer Lifetime Value
------------------------------------------------------------
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(
        oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)
    ),2) AS lifetime_value,
    RANK() OVER(
        ORDER BY SUM(
            oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)
        ) DESC
    ) AS customer_rank
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY c.customer_id,c.customer_name;

------------------------------------------------------------
-- 3. DENSE_RANK - Products by Revenue within Category
------------------------------------------------------------
SELECT
    category,
    product_name,
    revenue,
    DENSE_RANK() OVER(
        PARTITION BY category
        ORDER BY revenue DESC
    ) AS rank_in_category
FROM(
    SELECT
        p.category,
        p.product_name,
        SUM(
            oi.quantity*oi.unit_price*
            (1-oi.discount_percent/100.0)
        ) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id=oi.product_id
    GROUP BY p.category,p.product_name
);

------------------------------------------------------------
-- 4. Running Revenue by Region
------------------------------------------------------------
WITH daily_sales AS
(
SELECT
    o.region_code,
    DATE(o.order_date) AS sales_date,
    SUM(
        oi.quantity*oi.unit_price*
        (1-oi.discount_percent/100.0)
    ) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY o.region_code,DATE(o.order_date)
)

SELECT
    region_code,
    sales_date,
    ROUND(revenue,2) AS daily_revenue,
    ROUND(
        SUM(revenue)
        OVER(
            PARTITION BY region_code
            ORDER BY sales_date
        ),
    2) AS running_total
FROM daily_sales;

------------------------------------------------------------
-- 5. 7-Day Moving Average
------------------------------------------------------------
WITH daily AS
(
SELECT
    DATE(order_date) AS sales_date,
    SUM(
        oi.quantity*oi.unit_price*
        (1-oi.discount_percent/100.0)
    ) revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY DATE(order_date)
)

SELECT
    sales_date,
    ROUND(revenue,2) revenue,
    ROUND(
        AVG(revenue)
        OVER(
            ORDER BY sales_date
            ROWS BETWEEN 6 PRECEDING
            AND CURRENT ROW
        ),
    2) moving_average
FROM daily;

------------------------------------------------------------
-- 6. LAG - Previous Order Date
------------------------------------------------------------
SELECT
    customer_id,
    order_id,
    order_date,
    LAG(order_date)
        OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_order_date
FROM orders;

------------------------------------------------------------
-- 7. LEAD - Next Order Date
------------------------------------------------------------
SELECT
    customer_id,
    order_id,
    order_date,
    LEAD(order_date)
        OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS next_order_date
FROM orders;

------------------------------------------------------------
-- 8. FIRST_VALUE & LAST_VALUE
------------------------------------------------------------
WITH purchase_categories AS
(
SELECT
    o.customer_id,
    o.order_date,
    p.category
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id
)

SELECT
    customer_id,
    FIRST_VALUE(category)
        OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS first_category,

    LAST_VALUE(category)
        OVER(
            PARTITION BY customer_id
            ORDER BY order_date
            ROWS BETWEEN
            UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
        ) AS latest_category
FROM purchase_categories;

------------------------------------------------------------
-- 9. NTILE - Customer Quartiles
------------------------------------------------------------
WITH customer_revenue AS
(
SELECT
    c.customer_id,
    SUM(
        oi.quantity*oi.unit_price*
        (1-oi.discount_percent/100.0)
    ) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.customer_id
)

SELECT
    customer_id,
    ROUND(revenue,2) revenue,
    NTILE(4)
        OVER(
            ORDER BY revenue DESC
        ) quartile
FROM customer_revenue;

------------------------------------------------------------
-- 10. CUME_DIST
------------------------------------------------------------
WITH customer_revenue AS
(
SELECT
    c.customer_id,
    SUM(
        oi.quantity*oi.unit_price*
        (1-oi.discount_percent/100.0)
    ) revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.customer_id
)

SELECT
    customer_id,
    ROUND(revenue,2) revenue,
    CUME_DIST()
        OVER(
            ORDER BY revenue DESC
        ) cumulative_distribution
FROM customer_revenue;

------------------------------------------------------------
-- 11. PERCENT_RANK
------------------------------------------------------------
WITH customer_revenue AS
(
SELECT
    c.customer_id,
    SUM(
        oi.quantity*oi.unit_price*
        (1-oi.discount_percent/100.0)
    ) revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.customer_id
)

SELECT
    customer_id,
    ROUND(revenue,2) revenue,
    PERCENT_RANK()
        OVER(
            ORDER BY revenue DESC
        ) percent_rank
FROM customer_revenue;

-- ===========================================================
-- END
-- ===========================================================
