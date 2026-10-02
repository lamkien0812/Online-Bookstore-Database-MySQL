-- Purpose: Find customers whose total spending is above the average customer spending among paying customers.
USE online_bookstore;

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
