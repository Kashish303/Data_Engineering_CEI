SELECT
    product_category_name,
    latest_month_orders,
    previous_month_orders,
    order_growth,
    growth_percentage
FROM retailmart.gold.trending_product
ORDER BY growth_percentage DESC
LIMIT 10;