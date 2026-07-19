SELECT
    ROUND(AVG(total_spent),2) AS avg_order_value
FROM retailmart.gold.customer_360
WHERE total_orders > 0;