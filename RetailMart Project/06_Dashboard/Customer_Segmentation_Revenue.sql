SELECT
    customer_segment,
    COUNT(*) AS customer_count
FROM retailmart.gold.customer_segmentation
GROUP BY customer_segment
ORDER BY customer_count DESC;