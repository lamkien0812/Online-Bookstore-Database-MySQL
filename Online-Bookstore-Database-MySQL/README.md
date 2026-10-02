# Online Bookstore Database - MySQL

**Individual assignment: Database Design & SQL**

## Student information
- Full name: Lam Ngoc Kien
- Student ID: 134010126001
- Class: K26ISTG01

## 1. Project overview
This project designs an 8-table relational database for an online bookstore. It covers books, authors, publishers, categories, customers, orders, order items, and payments.

## 2. Main requirements covered
- ERD with 8 tables, PK/FK, 1:N and 1:1 relationships.
- 3NF normalization.
- 10-20 seed records in every table.
- Primary-key and unique constraints, NOT NULL, CHECK and DEFAULT.
- 4 indexes for frequent query patterns.
- 1 view, 1 stored procedure, 2 triggers.
- 12 SQL queries covering SELECT/WHERE/ORDER BY/LIMIT, INNER JOIN, LEFT JOIN, GROUP BY, aggregates, subqueries, nested queries, window functions, CASE WHEN, missing data, pagination and CTE.
- Optional bonus scripts for EXPLAIN, transaction, GRANT/REVOKE, backup/restore.
- GitHub Actions workflow using a MySQL 8 service.

## 3. Prerequisites
- MySQL 8.0+
- MySQL Workbench (recommended for screenshots)
- Git

## 4. Run the database
Open MySQL Workbench and run, in order:
```sql
SOURCE sql/01_schema.sql;
SOURCE sql/02_seed_data.sql;
SOURCE sql/03_objects.sql;
```
Then run `queries/all_queries.sql` or the individual files under `queries/`. Finally run `sql/04_validation.sql` to verify record counts and database objects.

> `sql/run_all.sql` contains `SOURCE` commands for a MySQL client working from the repository root.

## 5. Stored procedure example
```sql
CALL sp_create_order(1, 2, 2);
```
The procedure creates a pending order, inserts a line item, uses the trigger to validate/decrement stock and calculates the order total inside a transaction.

## 6. Repository structure

Online-Bookstore-Database-MySQL/
├── sql/
│   ├── 01_schema.sql
│   ├── 02_seed_data.sql
│   ├── 03_objects.sql
│   ├── 04_validation.sql
│   ├── 05_bonus.sql
│   └── run_all.sql
├── queries/
│   ├── Q01...Q12
│   └── all_queries.sql
├── erd/
│   ├── online_bookstore_erd.png
│   ├── online_bookstore_erd.svg
│   └── online_bookstore.dbml
├── docs/
│   ├── INDIVIDUAL_REPORT.docx
│   ├── INDIVIDUAL_REPORT.pdf
│   ├── COMPLEXITY.md
│   ├── QUERY_CATALOGUE.md
│   ├── DEMO.md
│   ├── MYSQL_TEST_CHECKLIST.md
│   └── query-results/
└── .github/workflows/mysql-ci.yml
```

## 7. Data volume
| Table | Seed records |
|---|---:|
| categories | 10 |
| authors | 10 |
| publishers | 10 |
| books | 20 |
| customers | 10 |
| orders | 10 |
| order_items | 20 |
| payments | 10 |

## 8. Query screenshots
`docs/query-results/` contains deterministic result previews for all 12 queries. Replace them with live MySQL Workbench screenshots before submission when literal screenshots are required.

## 9. Git workflow
Suggested commit messages:
- `feat: add normalized bookstore schema`
- `feat: seed sample bookstore data`
- `feat: add view procedure and triggers`
- `feat: add SQL query collection`
- `docs: add ERD and report`

## 10. Backup / restore
```bash
mysqldump -u root -p online_bookstore > online_bookstore_backup.sql
mysql -u root -p online_bookstore < online_bookstore_backup.sql
```