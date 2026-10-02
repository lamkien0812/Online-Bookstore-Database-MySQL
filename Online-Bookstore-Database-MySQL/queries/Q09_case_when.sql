-- Purpose: Classify books into price segments using CASE WHEN.
USE online_bookstore;

SELECT book_id, title, price,
  CASE
    WHEN price < 100000 THEN 'Budget'
    WHEN price < 180000 THEN 'Standard'
    ELSE 'Premium'
  END AS price_segment
FROM books
ORDER BY price;
