-- Purpose: Find customers who have never placed an order.
USE online_bookstore;

SELECT c.customer_id, c.full_name, c.email
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;
