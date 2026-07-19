SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM retailmart.gold.fact_sales;