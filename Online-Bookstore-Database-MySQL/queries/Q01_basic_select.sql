-- Purpose: List active books cheaper than 150,000 VND, sorted by price.
USE online_bookstore;

SELECT book_id, title, price, stock
FROM books
WHERE status = 'ACTIVE' AND price < 150000
ORDER BY price ASC
LIMIT 10;
