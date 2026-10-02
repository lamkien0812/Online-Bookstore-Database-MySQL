-- Online Bookstore Database - MySQL 8.x
-- Personal assignment: Database Design & SQL
-- Run files in order: 01_schema.sql -> 02_seed_data.sql -> 03_objects.sql -> 04_test_queries.sql

USE online_bookstore;

DROP VIEW IF EXISTS v_order_summary;
CREATE VIEW v_order_summary AS
SELECT
  o.order_id,
  o.order_date,
  o.status,
  c.customer_id,
  c.full_name AS customer_name,
  c.membership_level,
  o.shipping_fee,
  o.total_amount
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id;

DROP TRIGGER IF EXISTS trg_order_items_before_insert;
DROP TRIGGER IF EXISTS trg_payments_after_insert;
DROP PROCEDURE IF EXISTS sp_create_order;

DELIMITER $$
CREATE TRIGGER trg_order_items_before_insert
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
  DECLARE current_price DECIMAL(12,2);
  DECLARE current_stock INT;
  SELECT price, stock INTO current_price, current_stock
  FROM books WHERE book_id = NEW.book_id AND status = 'ACTIVE';
  IF current_price IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Book does not exist or is inactive';
  END IF;
  IF NEW.quantity > current_stock THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock';
  END IF;
  SET NEW.unit_price = current_price;
  UPDATE books SET stock = stock - NEW.quantity WHERE book_id = NEW.book_id;
END$$

CREATE TRIGGER trg_payments_after_insert
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
  IF NEW.payment_status = 'SUCCESS' THEN
    UPDATE orders SET status = 'PAID' WHERE order_id = NEW.order_id;
  END IF;
END$$

CREATE PROCEDURE sp_create_order(
  IN p_customer_id INT,
  IN p_book_id INT,
  IN p_quantity INT
)
BEGIN
  DECLARE v_order_id INT;
  DECLARE v_shipping DECIMAL(12,2) DEFAULT 30000;
  DECLARE v_total DECIMAL(12,2);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  IF p_quantity <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity must be positive';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM customers WHERE customer_id = p_customer_id) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer not found';
  END IF;

  START TRANSACTION;
  INSERT INTO orders (customer_id, order_date, status, total_amount, shipping_fee)
  VALUES (p_customer_id, NOW(), 'PENDING', 0, v_shipping);
  SET v_order_id = LAST_INSERT_ID();

  INSERT INTO order_items (order_id, book_id, quantity, unit_price)
  VALUES (v_order_id, p_book_id, p_quantity, 0);

  SELECT COALESCE(SUM(quantity * unit_price),0) + v_shipping INTO v_total
  FROM order_items WHERE order_id = v_order_id;

  UPDATE orders SET total_amount = v_total WHERE order_id = v_order_id;
  COMMIT;

  SELECT * FROM v_order_summary WHERE order_id = v_order_id;
END$$
DELIMITER ;
