-- Purpose: Calculate order count, total revenue, average order value, minimum and maximum order values.
USE online_bookstore;

SELECT
  COUNT(*) AS total_orders,
  SUM(total_amount) AS total_revenue,
  AVG(total_amount) AS avg_order_value,
  MIN(total_amount) AS min_order_value,
  MAX(total_amount) AS max_order_value
FROM orders
WHERE status IN ('PAID','COMPLETED');
