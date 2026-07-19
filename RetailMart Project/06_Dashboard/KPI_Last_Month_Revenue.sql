SELECT
    revenue_month,
    monthly_revenue
FROM retailmart.gold.monthly_revenue
ORDER BY
    order_year DESC,
    order_month DESC
LIMIT 1;