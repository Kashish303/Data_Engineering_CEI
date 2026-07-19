SELECT
    churn_risk_segment,
    COUNT(*) AS total_customers
FROM retailmart.gold.customer_churn
GROUP BY churn_risk_segment
ORDER BY total_customers DESC;