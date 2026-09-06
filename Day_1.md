
# SQL Commands

SQL commands are commonly divided into **5 main types**:

- **DDL — Data Definition Language:** Used to **create or modify database structure**.
  **Examples:** `CREATE`, `ALTER`, `DROP`, `TRUNCATE`

- **DML — Data Manipulation Language:** Used to **add, change, or delete data**.
  **Examples:** `INSERT`, `UPDATE`, `DELETE`

- **DQL — Data Query Language:** Used to **retrieve data from the database**.
  **Example:** `SELECT`

- **DCL — Data Control Language:** Used to **manage user permissions and access**.
  **Examples:** `GRANT`, `REVOKE`

- **TCL — Transaction Control Language:** Used to **manage database transactions**.
  **Examples:** `COMMIT`, `ROLLBACK`, `SAVEPOINT`

## Remember

**DDL → Structure | DML → Modify Data | DQL → Query Data | DCL → Permissions | TCL → Transactions**

---

# SQL Examples

## DDL — Data Definition Language

```sql
CREATE TABLE car_data (
    price INTEGER,
    purchase_date DATE,
    car_name VARCHAR(25),
    average_per_liter DECIMAL(3,1)
);
````

## DML — Data Manipulation Language

```sql
INSERT INTO car_data VALUES
(2500000, '2022-10-30', 'Suzuki Passo', 15.5),
(2500000, '2022-10-30', 'Suzuki Passo', 17.5),
(1500000, '2022-11-01', 'Suzuki Mehran', 14),
(3000000, '2022-12-05', 'Suzuki WagonR', 11.0),
(4500000, '2022-10-15', 'Suzuki Swift', 20.0),
(9500000, '2022-10-20', 'Civic Oriel', 10);
```

## SQL — Structured Query Language

### Select All Data

```sql
SELECT * FROM car_data;
```

### Limit Data

```sql
SELECT * FROM car_data
LIMIT 3;
```

### Data Sorting

```sql
SELECT car_name, price
FROM car_data
ORDER BY car_name ASC, price DESC;
```

## DELETE — Delete Data

```sql
DELETE FROM car_data;
```

## DROP — Delete Table

```sql
DROP TABLE car_data;
```
