SELECT
    customer_state,
    ROUND(SUM(total_item_value),2) AS state_revenue
FROM retailmart.gold.fact_sales
WHERE order_status = 'delivered'
GROUP BY customer_state
ORDER BY state_revenue DESC
LIMIT 10;