-- ===========================================================
-- cohort_analysis.sql
-- Advanced Cohort, Retention & Customer Segmentation Queries
-- E-Commerce Order Analytics System
-- ===========================================================

------------------------------------------------------------
-- 1. Customer Cohort (First Purchase Month)
------------------------------------------------------------
WITH first_purchase AS (
    SELECT
        customer_id,
        MIN(date(order_date)) AS first_purchase_date,
        strftime('%Y-%m', MIN(date(order_date))) AS cohort_month
    FROM orders
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT *
FROM first_purchase
ORDER BY cohort_month, customer_id;

------------------------------------------------------------
-- 2. Monthly Retention by Cohort
------------------------------------------------------------
WITH first_purchase AS (
    SELECT
        customer_id,
        strftime('%Y-%m', MIN(order_date)) AS cohort_month
    FROM orders
    GROUP BY customer_id
),
activity AS (
    SELECT
        o.customer_id,
        fp.cohort_month,
        strftime('%Y-%m', o.order_date) AS activity_month
    FROM orders o
    JOIN first_purchase fp
      ON o.customer_id = fp.customer_id
)
SELECT
    cohort_month,
    activity_month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM activity
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;

------------------------------------------------------------
-- 3. Repeat vs Churned Customers
------------------------------------------------------------
WITH order_counts AS (
SELECT customer_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
)
SELECT
customer_id,
total_orders,
CASE
WHEN total_orders=1 THEN 'One-Time'
WHEN total_orders BETWEEN 2 AND 5 THEN 'Repeat'
ELSE 'Loyal'
END AS customer_segment
FROM order_counts;

------------------------------------------------------------
-- 4. RFM Analysis
------------------------------------------------------------
WITH rfm AS (
SELECT
o.customer_id,
JULIANDAY('now')-JULIANDAY(MAX(date(o.order_date))) AS recency_days,
COUNT(DISTINCT o.order_id) AS frequency,
ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)),2) AS monetary
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY o.customer_id
)
SELECT *,
CASE
WHEN monetary>=10000 THEN 'High'
WHEN monetary>=5000 THEN 'Medium'
ELSE 'Low'
END AS spend_tier
FROM rfm;

------------------------------------------------------------
-- 5. Monthly Revenue Growth (Multi-Level CTE)
------------------------------------------------------------
WITH monthly AS (
SELECT
strftime('%Y-%m',order_date) AS month,
SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY month
),
growth AS (
SELECT
month,
revenue,
LAG(revenue) OVER(ORDER BY month) prev_revenue
FROM monthly
)
SELECT
month,
ROUND(revenue,2) revenue,
ROUND(prev_revenue,2) prev_revenue,
ROUND(((revenue-prev_revenue)/prev_revenue)*100,2) growth_percent
FROM growth;

------------------------------------------------------------
-- 6. Year-over-Year Revenue
------------------------------------------------------------
WITH yearly AS (
SELECT
strftime('%Y',order_date) year,
strftime('%m',order_date) month,
SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY year,month
)
SELECT
y1.year,
y1.month,
ROUND(y1.revenue,2) revenue,
ROUND(y2.revenue,2) prev_year_revenue,
CASE
WHEN y2.revenue IS NULL THEN NULL
ELSE ROUND(((y1.revenue-y2.revenue)/y2.revenue)*100,2)
END AS yoy_growth_percent
FROM yearly y1
LEFT JOIN yearly y2
ON y1.month=y2.month
AND CAST(y1.year AS INTEGER)=CAST(y2.year AS INTEGER)+1
ORDER BY y1.year,y1.month;

------------------------------------------------------------
-- 7. Cumulative Revenue Contribution
------------------------------------------------------------
WITH customer_revenue AS (
SELECT
c.customer_id,
SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) revenue
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY c.customer_id
)
SELECT
customer_id,
ROUND(revenue,2) revenue,
ROUND(SUM(revenue) OVER(ORDER BY revenue DESC),2) cumulative_revenue,
ROUND(
100.0*SUM(revenue) OVER(ORDER BY revenue DESC)/
SUM(revenue) OVER(),2
) cumulative_percent
FROM customer_revenue
ORDER BY revenue DESC;

------------------------------------------------------------
-- 8. Frequently Bought Together Products
------------------------------------------------------------
SELECT
oi1.product_id AS product_a,
oi2.product_id AS product_b,
COUNT(*) AS times_bought_together
FROM order_items oi1
JOIN order_items oi2
ON oi1.order_id=oi2.order_id
AND oi1.product_id<oi2.product_id
GROUP BY oi1.product_id,oi2.product_id
ORDER BY times_bought_together DESC;

-- ===========================================================
-- END OF FILE
-- ===========================================================
