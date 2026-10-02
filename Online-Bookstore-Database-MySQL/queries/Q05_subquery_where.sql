-- Purpose: Find books priced above the average book price.
USE online_bookstore;

SELECT book_id, title, price
FROM books
WHERE price > (SELECT AVG(price) FROM books)
ORDER BY price DESC;
