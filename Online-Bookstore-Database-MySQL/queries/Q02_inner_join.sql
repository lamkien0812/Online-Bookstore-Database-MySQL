-- Purpose: Show orders with customer information using INNER JOIN.
USE online_bookstore;

SELECT o.order_id, c.full_name, o.order_date, o.status, o.total_amount
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;
