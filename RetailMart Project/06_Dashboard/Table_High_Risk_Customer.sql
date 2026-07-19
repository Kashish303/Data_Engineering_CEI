SELECT
    customer_id,
    customer_city,
    customer_state,
    total_orders,
    total_spent,
    last_purchase,
    days_since_last_purchase
FROM retailmart.gold.customer_churn
WHERE churn_risk_segment = 'High Risk - Likely Churned'
ORDER BY days_since_last_purchase DESC
LIMIT 10;