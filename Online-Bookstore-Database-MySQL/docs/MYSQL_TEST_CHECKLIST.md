# MySQL Test Checklist

Run in MySQL 8.x:

- [ ] `SOURCE sql/01_schema.sql` succeeds.
- [ ] `SOURCE sql/02_seed_data.sql` succeeds.
- [ ] `SOURCE sql/03_objects.sql` succeeds.
- [ ] Run `sql/04_validation.sql` and confirm 10 categories, 10 authors, 10 publishers, 20 books, 10 customers, 10 orders, 20 order_items and 10 payments.
- [ ] `SELECT * FROM v_order_summary;` returns 10 rows.
- [ ] `CALL sp_create_order(1, 2, 1);` creates a new order.
- [ ] Trigger rejects a quantity above available stock.
- [ ] Successful payment sets order status to `PAID`.
- [ ] All Q01-Q12 execute without syntax errors.
- [ ] Capture live screenshots in MySQL Workbench for the final submission.
