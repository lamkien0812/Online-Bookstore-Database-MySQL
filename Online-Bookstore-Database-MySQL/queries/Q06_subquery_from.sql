-- Purpose: Calculate sales totals per category using a subquery in FROM.
USE online_bookstore;

SELECT category_name, sold_units, revenue
FROM (
  SELECT c.category_name,
         SUM(oi.quantity) AS sold_units,
         SUM(oi.quantity * oi.unit_price) AS revenue
  FROM categories c
  JOIN books b ON b.category_id = c.category_id
  JOIN order_items oi ON oi.book_id = b.book_id
  JOIN orders o ON o.order_id = oi.order_id
  WHERE o.status IN ('PAID','COMPLETED')
  GROUP BY c.category_name
) AS category_sales
ORDER BY revenue DESC;
