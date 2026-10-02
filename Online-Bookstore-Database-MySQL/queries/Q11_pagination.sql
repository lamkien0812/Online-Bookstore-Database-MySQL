-- Purpose: Return page 2 of books, 5 rows per page.
USE online_bookstore;

SELECT book_id, title, price
FROM books
WHERE status = 'ACTIVE'
ORDER BY book_id
LIMIT 5 OFFSET 5;
