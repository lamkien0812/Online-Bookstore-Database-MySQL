-- Optional bonus SQL for MySQL 8.x
USE online_bookstore;

-- EXPLAIN the indexed lookup. Compare the execution plan before and after dropping/recreating the index in a test copy.
EXPLAIN SELECT book_id, title, price FROM books WHERE category_id = 2 AND price < 150000 ORDER BY price;

-- Transaction example
START TRANSACTION;
UPDATE books SET stock = stock + 1 WHERE book_id = 1;
-- COMMIT;
-- ROLLBACK;
ROLLBACK;

-- Example least-privilege user (run only with administrative privileges).
-- CREATE USER 'bookstore_readonly'@'localhost' IDENTIFIED BY 'ChangeThisPassword!';
-- GRANT SELECT ON online_bookstore.* TO 'bookstore_readonly'@'localhost';
-- REVOKE DELETE ON online_bookstore.* FROM 'bookstore_readonly'@'localhost';

-- Backup and restore examples (run in OS shell, not inside MySQL):
-- mysqldump -u root -p online_bookstore > online_bookstore_backup.sql
-- mysql -u root -p online_bookstore < online_bookstore_backup.sql
