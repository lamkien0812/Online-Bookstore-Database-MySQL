# Complexity Analysis

| Component | Main operation | Time | Space |
|---|---|---:|---:|
| Book lookup by primary key | `WHERE book_id = ?` | O(log n) with B-tree index | O(1) extra |
| Book title search | indexed prefix / scan depending on predicate | O(log n) to O(n) | O(1) extra |
| Order/customer join | indexed FK lookup | approximately O(n log m) | O(result) |
| GROUP BY revenue | aggregate across rows | O(n log n) typical | O(g) |
| Window ranking | sort + rank | O(n log n) | O(n) |
| CTE monthly report | scan + group | O(n log n) typical | O(g) |

## Normalization to 3NF

**1NF:** every column stores atomic data and each table has a primary key.

**2NF:** order-level data is separated from order-line data. Non-key fields depend on the whole row identity.

**3NF:** author, publisher and category descriptions are stored in their own tables. Customer fields stay in `customers` and order fields stay in `orders`, preventing transitive dependencies.

## Index rationale

- `idx_books_title` supports common title lookup patterns.
- `idx_books_category_price` supports category + price filtering.
- `idx_orders_customer_date` supports customer order history by date.
- `idx_order_items_book` supports joins and sales analysis by book.

Use `EXPLAIN` in MySQL Workbench to confirm the actual plan on the target environment.
