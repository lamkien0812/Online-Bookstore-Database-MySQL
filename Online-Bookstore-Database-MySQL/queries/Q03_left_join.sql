-- Purpose: Show every customer, including customers who have no orders, using LEFT JOIN.
USE online_bookstore;

SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY order_count DESC, c.customer_id;
