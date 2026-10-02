-- Purpose: Use a CTE to calculate monthly revenue and order count.
USE online_bookstore;

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
