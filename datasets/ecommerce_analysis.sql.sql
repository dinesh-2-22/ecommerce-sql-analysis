show databases;

create database ecommerce ;
use ecommerce ;
select database ();
show TABLES ;
SELECT COUNT(*) 
FROM olist_orders_dataset;

select count(*)
from olist_order_payments_dataset;

SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    ROUND(SUM(p.payment_value),2) AS revenue
    
    
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY year
ORDER BY year;

select order_id ,count(*)
from olist_order_payments_dataset 
group by order_id 
having count(*)>1 ; 


WITH payment_per_order AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_payment
    FROM olist_order_payments_dataset
    GROUP BY order_id
)

SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    ROUND(SUM(p.total_payment),2) AS revenue
FROM olist_orders_dataset o
JOIN payment_per_order p
ON o.order_id = p.order_id
GROUP BY year
ORDER BY year;

SELECT 
    YEAR(order_purchase_timestamp) AS year,
    COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY year
ORDER BY year;

SELECT 
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id;

SELECT 
    YEAR(o.order_purchase_timestamp) AS year,
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY year
ORDER BY year;

SELECT 
    payment_type,
    ROUND(SUM(payment_value),2) AS total_revenue
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_revenue DESC;
WITH payment_per_order AS (
    SELECT 
        order_id,
        SUM(payment_value) AS total_payment
    FROM olist_order_payments_dataset
    GROUP BY order_id
)

SELECT *
FROM payment_per_order
ORDER BY total_payment DESC
LIMIT 10;

SELECT 
    o.customer_id,
    ROUND(SUM(p.payment_value),2) AS total_spent
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;

WITH customer_spending AS (
    SELECT
        o.customer_id,
        SUM(p.payment_value) AS total_spent
    FROM olist_orders_dataset o
    JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id
    GROUP BY o.customer_id
)

SELECT
    customer_id,
    ROUND(total_spent,2) AS total_spent,
    CASE
        WHEN total_spent >= 5000 THEN 'Gold'
        WHEN total_spent >= 1000 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_tier
FROM customer_spending
ORDER BY total_spent DESC
LIMIT 20;


WITH customer_spending AS (
    SELECT
        o.customer_id,
        SUM(p.payment_value) AS total_spent
    FROM olist_orders_dataset o
    JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id
    GROUP BY o.customer_id
)

SELECT
    CASE
        WHEN total_spent >= 5000 THEN 'Gold'
        WHEN total_spent >= 1000 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_tier,
    COUNT(*) AS number_of_customers
FROM customer_spending
GROUP BY customer_tier;


WITH customer_spending AS (
    SELECT
        o.customer_id,
        SUM(p.payment_value) AS total_spent
    FROM olist_orders_dataset o
    JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id
    GROUP BY o.customer_id
),

customer_tiers AS (
    SELECT
        customer_id,
        total_spent,
        CASE
            WHEN total_spent >= 5000 THEN 'Gold'
            WHEN total_spent >= 1000 THEN 'Silver'
            ELSE 'Bronze'
        END AS customer_tier
    FROM customer_spending
)

SELECT
    customer_tier,
    ROUND(SUM(total_spent),2) AS tier_revenue,
    ROUND(
        SUM(total_spent) * 100 /
        SUM(SUM(total_spent)) OVER (),
        2
    ) AS revenue_percentage
FROM customer_tiers
GROUP BY customer_tier
ORDER BY tier_revenue DESC;

SELECT
    order_type,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        customer_id,
        CASE
            WHEN COUNT(order_id) = 1 THEN 'One-time'
            ELSE 'Repeat'
        END AS order_type
    FROM olist_orders_dataset
    GROUP BY customer_id
) t
GROUP BY order_type;
SELECT
    CASE
        WHEN total_spent >= 5000 THEN 'High Value'
        WHEN total_spent >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(AVG(total_spent),2) AS avg_spent
FROM customer_spending
GROUP BY customer_segment
ORDER BY avg_spent DESC;

WITH customer_spending AS (
    SELECT
        o.customer_id,
        SUM(p.payment_value) AS total_spent
    FROM olist_orders_dataset o
    JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id
    GROUP BY o.customer_id
)

SELECT
    CASE
        WHEN total_spent >= 5000 THEN 'High Value'
        WHEN total_spent >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(AVG(total_spent),2) AS avg_spent
FROM customer_spending
GROUP BY customer_segment
ORDER BY avg_spent DESC; WITH customer_spending AS (
    SELECT
        o.customer_id,
        SUM(p.payment_value) AS total_spent
    FROM olist_orders_dataset o
    JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id
    GROUP BY o.customer_id
)

SELECT
    CASE
        WHEN total_spent >= 5000 THEN 'High Value'
        WHEN total_spent >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(AVG(total_spent),2) AS avg_spent
FROM customer_spending
GROUP BY customer_segment
ORDER BY avg_spent DESC;

WITH customer_spending AS (
    SELECT
        o.customer_id,
        SUM(p.payment_value) AS total_spent
    FROM olist_orders_dataset o
    JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id
    GROUP BY o.customer_id
)

SELECT
    CASE
        WHEN total_spent >= 5000 THEN 'High Value'
        WHEN total_spent >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(AVG(total_spent),2) AS avg_spent
FROM customer_spending
GROUP BY customer_segment
ORDER BY avg_spent DESC;  
