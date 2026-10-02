-- Query collection for Online Bookstore Database
-- Run after 01_schema.sql, 02_seed_data.sql, and 03_objects.sql
USE online_bookstore;

-- Q01_basic_select.sql: List active books cheaper than 150,000 VND, sorted by price.
SELECT book_id, title, price, stock
FROM books
WHERE status = 'ACTIVE' AND price < 150000
ORDER BY price ASC
LIMIT 10;

-- Q02_inner_join.sql: Show orders with customer information using INNER JOIN.
SELECT o.order_id, c.full_name, o.order_date, o.status, o.total_amount
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;

-- Q03_left_join.sql: Show every customer, including customers who have no orders, using LEFT JOIN.
SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY order_count DESC, c.customer_id;

-- Q04_group_by.sql: Calculate order count, total revenue, average order value, minimum and maximum order values.
SELECT
  COUNT(*) AS total_orders,
  SUM(total_amount) AS total_revenue,
  AVG(total_amount) AS avg_order_value,
  MIN(total_amount) AS min_order_value,
  MAX(total_amount) AS max_order_value
FROM orders
WHERE status IN ('PAID','COMPLETED');

-- Q05_subquery_where.sql: Find books priced above the average book price.
SELECT book_id, title, price
FROM books
WHERE price > (SELECT AVG(price) FROM books)
ORDER BY price DESC;

-- Q06_subquery_from.sql: Calculate sales totals per category using a subquery in FROM.
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

-- Q07_window_rank.sql: Rank books by their total sold quantity using a window function.
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

-- Q08_nested_query.sql: Find customers whose total spending is above the average customer spending among paying customers.
SELECT c.customer_id, c.full_name, SUM(o.total_amount) AS customer_spend
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status IN ('PAID','COMPLETED')
GROUP BY c.customer_id, c.full_name
HAVING SUM(o.total_amount) > (
  SELECT AVG(customer_total)
  FROM (
    SELECT customer_id, SUM(total_amount) AS customer_total
    FROM orders
    WHERE status IN ('PAID','COMPLETED')
    GROUP BY customer_id
  ) AS customer_totals
)
ORDER BY customer_spend DESC;

-- Q09_case_when.sql: Classify books into price segments using CASE WHEN.
SELECT book_id, title, price,
  CASE
    WHEN price < 100000 THEN 'Budget'
    WHEN price < 180000 THEN 'Standard'
    ELSE 'Premium'
  END AS price_segment
FROM books
ORDER BY price;

-- Q10_duplicate_or_missing.sql: Find customers who have never placed an order.
SELECT c.customer_id, c.full_name, c.email
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;

-- Q11_pagination.sql: Return page 2 of books, 5 rows per page.
SELECT book_id, title, price
FROM books
WHERE status = 'ACTIVE'
ORDER BY book_id
LIMIT 5 OFFSET 5;

-- Q12_cte.sql: Use a CTE to calculate monthly revenue and order count.
WITH monthly_sales AS (
  SELECT DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
         COUNT(*) AS order_count,
         SUM(total_amount) AS revenue
  FROM orders
  WHERE status IN ('PAID','COMPLETED')
  GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT sales_month, order_count, revenue,
       RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM monthly_sales
ORDER BY sales_month;

