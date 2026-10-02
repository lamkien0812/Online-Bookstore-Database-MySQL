-- Online Bookstore Database - MySQL 8.x
-- Personal assignment: Database Design & SQL
-- Run files in order: 01_schema.sql -> 02_seed_data.sql -> 03_objects.sql -> 04_test_queries.sql

USE online_bookstore;

INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Fiction', 'Novels and stories'),
(2, 'Self Help', 'Personal development'),
(3, 'Business', 'Business and management'),
(4, 'Technology', 'Programming and technology'),
(5, 'Science', 'Science and popular science'),
(6, 'History', 'History and culture'),
(7, 'Biography', 'Biographies and memoirs'),
(8, 'Children', 'Books for children'),
(9, 'Education', 'Learning and study'),
(10, 'Psychology', 'Psychology and behavior');

INSERT INTO authors (author_id, author_name, country) VALUES
(1, 'Paulo Coelho', 'Brazil'),
(2, 'James Clear', 'United States'),
(3, 'Dale Carnegie', 'United States'),
(4, 'Robert Kiyosaki', 'United States'),
(5, 'Yuval Noah Harari', 'Israel'),
(6, 'J.K. Rowling', 'United Kingdom'),
(7, 'George Orwell', 'United Kingdom'),
(8, 'Stephen Hawking', 'United Kingdom'),
(9, 'Daniel Goleman', 'United States'),
(10, 'Cal Newport', 'United States');

INSERT INTO publishers (publisher_id, publisher_name, phone) VALUES
(1, 'River Press', '0901000001'),
(2, 'Clear House', '0901000002'),
(3, 'Success Books', '0901000003'),
(4, 'Learning Tree', '0901000004'),
(5, 'Future Insight', '0901000005'),
(6, 'Classic World', '0901000006'),
(7, 'Science Gate', '0901000007'),
(8, 'Mindful Pages', '0901000008'),
(9, 'Academic House', '0901000009'),
(10, 'North Star Publishing', '0901000010');

INSERT INTO books (book_id, title, isbn, author_id, publisher_id, category_id, published_year, price, stock, status) VALUES
(1, 'The Alchemist', '9780000000001', 1, 1, 1, 1988, 89000, 30, 'ACTIVE'),
(2, 'Atomic Habits', '9780000000002', 2, 2, 2, 2018, 120000, 25, 'ACTIVE'),
(3, 'How to Win Friends and Influence People', '9780000000003', 3, 3, 2, 1936, 99000, 28, 'ACTIVE'),
(4, 'Rich Dad Poor Dad', '9780000000004', 4, 3, 3, 1997, 115000, 20, 'ACTIVE'),
(5, 'Sapiens', '9780000000005', 5, 5, 6, 2011, 180000, 18, 'ACTIVE'),
(6, 'Harry Potter and the Philosopher''s Stone', '9780000000006', 6, 6, 8, 1997, 150000, 22, 'ACTIVE'),
(7, '1984', '9780000000007', 7, 6, 1, 1949, 95000, 16, 'ACTIVE'),
(8, 'A Brief History of Time', '9780000000008', 8, 7, 5, 1988, 175000, 12, 'ACTIVE'),
(9, 'Emotional Intelligence', '9780000000009', 9, 8, 10, 1995, 160000, 14, 'ACTIVE'),
(10, 'Deep Work', '9780000000010', 10, 10, 4, 2016, 145000, 24, 'ACTIVE'),
(11, 'The Psychology of Money', '9780000000011', 10, 8, 10, 2020, 155000, 19, 'ACTIVE'),
(12, 'The Power of Habit', '9780000000012', 2, 2, 2, 2012, 110000, 26, 'ACTIVE'),
(13, 'The Intelligent Investor', '9780000000013', 4, 3, 3, 1949, 210000, 10, 'ACTIVE'),
(14, 'Thinking, Fast and Slow', '9780000000014', 9, 5, 10, 2011, 190000, 11, 'ACTIVE'),
(15, 'Zero to One', '9780000000015', 4, 9, 3, 2014, 130000, 17, 'ACTIVE'),
(16, 'Clean Code', '9780000000016', 10, 4, 4, 2008, 220000, 13, 'ACTIVE'),
(17, 'The Pragmatic Programmer', '9780000000017', 10, 4, 4, 1999, 230000, 9, 'ACTIVE'),
(18, 'The Little Prince', '9780000000018', 1, 6, 8, 1943, 85000, 32, 'ACTIVE'),
(19, 'Educated', '9780000000019', 7, 9, 7, 2018, 170000, 8, 'ACTIVE'),
(20, 'The 7 Habits of Highly Effective People', '9780000000020', 3, 3, 2, 1989, 125000, 21, 'ACTIVE');

INSERT INTO customers (customer_id, full_name, email, phone, membership_level, registered_at) VALUES
(1, 'Nguyen An', 'an.nguyen@example.com', '0909000001', 'BASIC', '2026-01-10 09:00:00'),
(2, 'Tran Binh', 'binh.tran@example.com', '0909000002', 'VIP', '2026-01-12 10:00:00'),
(3, 'Le Chi', 'chi.le@example.com', '0909000003', 'PREMIUM', '2026-01-15 11:00:00'),
(4, 'Pham Dung', 'dung.pham@example.com', '0909000004', 'BASIC', '2026-01-18 14:00:00'),
(5, 'Hoang Giang', 'giang.hoang@example.com', '0909000005', 'VIP', '2026-02-01 09:30:00'),
(6, 'Vu Hanh', 'hanh.vu@example.com', '0909000006', 'BASIC', '2026-02-06 15:00:00'),
(7, 'Do Khoa', 'khoa.do@example.com', '0909000007', 'PREMIUM', '2026-02-10 16:00:00'),
(8, 'Bui Linh', 'linh.bui@example.com', '0909000008', 'BASIC', '2026-02-12 08:30:00'),
(9, 'Dang Minh', 'minh.dang@example.com', '0909000009', 'BASIC', '2026-02-18 13:00:00'),
(10, 'Nguyen Phuong', 'phuong.nguyen@example.com', '0909000010', 'BASIC', '2026-03-01 10:15:00');

INSERT INTO orders (order_id, customer_id, order_date, status, total_amount, shipping_fee) VALUES
(1, 1, '2026-03-01 09:00:00', 'PAID', 329000, 0),
(2, 2, '2026-03-03 11:20:00', 'PAID', 348000, 0),
(3, 3, '2026-03-05 14:15:00', 'PAID', 340000, 0),
(4, 4, '2026-03-07 16:30:00', 'PAID', 439000, 0),
(5, 5, '2026-03-10 10:10:00', 'PAID', 345000, 0),
(6, 6, '2026-03-12 13:45:00', 'PAID', 450000, 0),
(7, 7, '2026-03-15 18:20:00', 'PAID', 480000, 0),
(8, 8, '2026-03-18 12:00:00', 'COMPLETED', 350000, 0),
(9, 9, '2026-03-20 17:00:00', 'PENDING', 280000, 30000),
(10, 10, '2026-03-22 09:40:00', 'PAID', 535000, 0);

INSERT INTO order_items (order_item_id, order_id, book_id, quantity, unit_price) VALUES
(101, 1, 2, 2, 120000),
(102, 1, 1, 1, 89000),
(201, 2, 3, 2, 99000),
(202, 2, 6, 1, 150000),
(301, 3, 5, 1, 180000),
(302, 3, 9, 2, 160000),
(401, 4, 8, 2, 175000),
(402, 4, 11, 1, 155000),
(501, 5, 12, 2, 110000),
(502, 5, 4, 1, 115000),
(601, 6, 16, 1, 220000),
(602, 6, 15, 2, 130000),
(701, 7, 10, 2, 145000),
(702, 7, 19, 1, 170000),
(801, 8, 18, 3, 85000),
(802, 8, 12, 1, 110000),
(901, 9, 14, 1, 190000),
(902, 9, 7, 2, 95000),
(1001, 10, 20, 2, 125000),
(1002, 10, 13, 1, 210000);

INSERT INTO payments (payment_id, order_id, amount, payment_method, payment_date, payment_status) VALUES
(1, 1, 329000, 'CASH', '2026-03-03 19:00:00', 'SUCCESS'),
(2, 2, 348000, 'BANK_TRANSFER', '2026-03-05 19:00:00', 'SUCCESS'),
(3, 3, 340000, 'CASH', '2026-03-07 19:00:00', 'SUCCESS'),
(4, 4, 439000, 'BANK_TRANSFER', '2026-03-09 19:00:00', 'SUCCESS'),
(5, 5, 345000, 'CASH', '2026-03-12 19:00:00', 'SUCCESS'),
(6, 6, 450000, 'BANK_TRANSFER', '2026-03-14 19:00:00', 'SUCCESS'),
(7, 7, 480000, 'CASH', '2026-03-17 19:00:00', 'SUCCESS'),
(8, 8, 350000, 'BANK_TRANSFER', '2026-03-20 19:00:00', 'SUCCESS'),
(9, 9, 280000, 'CASH', '2026-03-22 19:00:00', 'FAILED'),
(10, 10, 535000, 'BANK_TRANSFER', '2026-03-24 19:00:00', 'SUCCESS');

