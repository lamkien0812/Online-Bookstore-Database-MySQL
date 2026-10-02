-- Online Bookstore Database - MySQL 8.x
-- Personal assignment: Database Design & SQL
-- Run files in order: 01_schema.sql -> 02_seed_data.sql -> 03_objects.sql -> 04_test_queries.sql

DROP DATABASE IF EXISTS online_bookstore;
CREATE DATABASE online_bookstore CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE online_bookstore;

CREATE TABLE categories (
  category_id INT PRIMARY KEY AUTO_INCREMENT,
  category_name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL
) ENGINE=InnoDB;

CREATE TABLE authors (
  author_id INT PRIMARY KEY AUTO_INCREMENT,
  author_name VARCHAR(150) NOT NULL,
  country VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE publishers (
  publisher_id INT PRIMARY KEY AUTO_INCREMENT,
  publisher_name VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL UNIQUE,
  CONSTRAINT chk_publisher_phone CHECK (CHAR_LENGTH(phone) BETWEEN 10 AND 20)
) ENGINE=InnoDB;

CREATE TABLE books (
  book_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(200) NOT NULL,
  isbn VARCHAR(20) NOT NULL UNIQUE,
  author_id INT NOT NULL,
  publisher_id INT NOT NULL,
  category_id INT NOT NULL,
  published_year SMALLINT NOT NULL,
  price DECIMAL(12,2) NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  status ENUM('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT chk_book_year CHECK (published_year BETWEEN 1000 AND 2100),
  CONSTRAINT chk_book_price CHECK (price >= 0),
  CONSTRAINT chk_book_stock CHECK (stock >= 0),
  CONSTRAINT fk_book_author FOREIGN KEY (author_id) REFERENCES authors(author_id),
  CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id),
  CONSTRAINT fk_book_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL UNIQUE,
  membership_level ENUM('BASIC','PREMIUM','VIP') NOT NULL DEFAULT 'BASIC',
  registered_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status ENUM('PENDING','PAID','SHIPPED','COMPLETED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  total_amount DECIMAL(12,2) NOT NULL DEFAULT 0,
  shipping_fee DECIMAL(12,2) NOT NULL DEFAULT 0,
  CONSTRAINT chk_order_total CHECK (total_amount >= 0),
  CONSTRAINT chk_shipping_fee CHECK (shipping_fee >= 0),
  CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
) ENGINE=InnoDB;

CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  book_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  CONSTRAINT uq_order_book UNIQUE (order_id, book_id),
  CONSTRAINT chk_item_quantity CHECK (quantity > 0),
  CONSTRAINT chk_item_price CHECK (unit_price >= 0),
  CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
  CONSTRAINT fk_item_book FOREIGN KEY (book_id) REFERENCES books(book_id)
) ENGINE=InnoDB;

CREATE TABLE payments (
  payment_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL UNIQUE,
  amount DECIMAL(12,2) NOT NULL,
  payment_method ENUM('CASH','BANK_TRANSFER','CARD','E_WALLET') NOT NULL,
  payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  payment_status ENUM('SUCCESS','FAILED','REFUNDED') NOT NULL DEFAULT 'SUCCESS',
  CONSTRAINT chk_payment_amount CHECK (amount >= 0),
  CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Indexes for frequent lookups
CREATE INDEX idx_books_title ON books(title);
CREATE INDEX idx_books_category_price ON books(category_id, price);
CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_order_items_book ON order_items(book_id);
