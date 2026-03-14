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
