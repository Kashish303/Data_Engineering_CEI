SELECT
    funnel_stage AS order_status,
    total_revenue,
    total_orders
FROM retailmart.gold.funnel_analysis
ORDER BY total_revenue DESC;