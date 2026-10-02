# Query Catalogue

Run `sql/01_schema.sql`, `sql/02_seed_data.sql`, and `sql/03_objects.sql` first.

| Query | Requirement | Purpose | Result preview |
|---|---|---|---|
| Q01 | SELECT + WHERE + ORDER BY + LIMIT | List affordable active books | `query-results/Q01.png` |
| Q02 | INNER JOIN | Combine order and customer data | `query-results/Q02.png` |
| Q03 | LEFT JOIN | Include all customers and order counts | `query-results/Q03.png` |
| Q04 | GROUP BY + aggregates | Revenue statistics | `query-results/Q04.png` |
| Q05 | Subquery in WHERE | Books above average price | `query-results/Q05.png` |
| Q06 | Subquery in FROM | Revenue by category | `query-results/Q06.png` |
| Q07 | Window function | Rank books by units sold | `query-results/Q07.png` |
| Q08 | Nested query | Customers above average spend | `query-results/Q08.png` |
| Q09 | CASE WHEN | Price segmentation | `query-results/Q09.png` |
| Q10 | Missing data | Customers without orders | `query-results/Q10.png` |
| Q11 | Pagination | Page 2, five books per page | `query-results/Q11.png` |
| Q12 | CTE + window | Monthly revenue ranking | `query-results/Q12.png` |

> The included PNGs are deterministic previews generated from the seeded dataset because a MySQL server is not available in the build environment. Capture live screenshots in MySQL Workbench before final submission when required.
