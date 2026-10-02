-- Purpose: Rank books by their total sold quantity using a window function.
USE online_bookstore;

WITH book_sales AS (
  SELECT b.book_id, b.title, SUM(oi.quantity) AS sold_units
  FROM books b
  JOIN order_items oi ON oi.book_id = b.book_id
  JOIN orders o ON o.order_id = oi.order_id
  WHERE o.status IN ('PAID','COMPLETED')
  GROUP BY b.book_id, b.title
)
SELECT book_id, title, sold_units,
       RANK() OVER (ORDER BY sold_units DESC) AS sales_rank
FROM book_sales
ORDER BY sales_rank, title;
