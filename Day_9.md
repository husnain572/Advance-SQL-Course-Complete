
# 1. Dummy Table

First we create a simple employee table.

```sql
CREATE TABLE employee (
emp_id INT,
name VARCHAR(50),
dept_id INT,
salary INT
);
```

Insert data

```sql
INSERT INTO employee VALUES
(1,'Ali',1,50000),
(2,'Ahmed',1,60000),
(3,'Sara',2,55000),
(4,'Hina',2,70000),
(5,'Usman',3,65000);
```

Table:

| emp_id | name  | dept_id | salary |
| ------ | ----- | ------- | ------ |
| 1      | Ali   | 1       | 50000  |
| 2      | Ahmed | 1       | 60000  |
| 3      | Sara  | 2       | 55000  |
| 4      | Hina  | 2       | 70000  |
| 5      | Usman | 3       | 65000  |

---

# 2. Window Functions (Core Concept)

Normally when we use **GROUP BY**, rows collapse.

Example:

```sql
SELECT dept_id, SUM(salary)
FROM employee
GROUP BY dept_id;
```

Result

| dept | total  |
| ---- | ------ |
| 1    | 110000 |
| 2    | 125000 |
| 3    | 65000  |

But **window functions do NOT collapse rows**.

Example

```sql
SELECT *,
SUM(salary) OVER(PARTITION BY dept_id) AS dept_salary
FROM employee;
```

Result

| emp   | dept | salary | dept_salary |
| ----- | ---- | ------ | ----------- |
| Ali   | 1    | 50000  | 110000      |
| Ahmed | 1    | 60000  | 110000      |
| Sara  | 2    | 55000  | 125000      |
| Hina  | 2    | 70000  | 125000      |
| Usman | 3    | 65000  | 65000       |

✔ Row level data still exists
✔ Aggregated value also appears

This is **window function power**.

# 3. ROW_NUMBER()

ROW_NUMBER assigns **sequential numbers inside partitions**.

```sql
SELECT *,
ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn
FROM employee;
```

Result

| name  | dept | salary | rn |
| ----- | ---- | ------ | -- |
| Ahmed | 1    | 60000  | 1  |
| Ali   | 1    | 50000  | 2  |
| Hina  | 2    | 70000  | 1  |
| Sara  | 2    | 55000  | 2  |
| Usman | 3    | 65000  | 1  |

Use case:

✔ Top employees per department
✔ Ranking data

# 4. Real Interview Problem: Call Duration

We have two tables.

## Call Start Logs

```sql
CREATE TABLE call_start_logs(
phone_number VARCHAR(20),
start_time DATETIME
);
```

```sql
INSERT INTO call_start_logs VALUES
('111', '2024-01-01 10:00'),
('111', '2024-01-01 11:00'),
('222', '2024-01-01 09:00');
```

## Call End Logs

```sql
CREATE TABLE call_end_logs(
phone_number VARCHAR(20),
end_time DATETIME
);
```

```sql
INSERT INTO call_end_logs VALUES
('111','2024-01-01 10:10'),
('111','2024-01-01 11:20'),
('222','2024-01-01 09:30');
```

# 5. Pairing Calls using ROW_NUMBER()

We assign row numbers.

Start table

```sql
SELECT *,
ROW_NUMBER() OVER(PARTITION BY phone_number ORDER BY start_time) rn
FROM call_start_logs
```

End table

```sql
SELECT *,
ROW_NUMBER() OVER(PARTITION BY phone_number ORDER BY end_time) rn
FROM call_end_logs
```

Then join.

```sql
SELECT
s.phone_number,
s.start_time,
e.end_time,
DATEDIFF(MINUTE,s.start_time,e.end_time) AS duration
FROM
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY phone_number ORDER BY start_time) rn
FROM call_start_logs
) s

JOIN
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY phone_number ORDER BY end_time) rn
FROM call_end_logs
) e

ON s.phone_number=e.phone_number
AND s.rn=e.rn;
```

Result

| phone | start | end   | duration |
| ----- | ----- | ----- | -------- |
| 111   | 10:00 | 10:10 | 10       |
| 111   | 11:00 | 11:20 | 20       |
| 222   | 09:00 | 09:30 | 30       |

# 6. MAX Window Function

```sql
SELECT *,
MAX(salary) OVER(PARTITION BY dept_id) AS max_dept_salary
FROM employee;
```

Result

| name  | dept | salary | max_dept |
| ----- | ---- | ------ | -------- |
| Ali   | 1    | 50000  | 60000    |
| Ahmed | 1    | 60000  | 60000    |
| Sara  | 2    | 55000  | 70000    |
| Hina  | 2    | 70000  | 70000    |

# 7. Running Maximum

```sql
SELECT *,
MAX(salary) OVER(ORDER BY salary DESC) AS running_max
FROM employee;
```

It keeps updating maximum value.

---

# 8. Running Total

```sql
SELECT *,
SUM(salary) OVER(ORDER BY emp_id) AS running_salary
FROM employee;
```

Result

| emp | salary | running |
| --- | ------ | ------- |
| 1   | 50000  | 50000   |
| 2   | 60000  | 110000  |
| 3   | 55000  | 165000  |
| 4   | 70000  | 235000  |

This is **cumulative sum**.

# 9. Window Frame

Window functions also use **frames**.

Example

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

Meaning

Start → first row
End → current row

Example

```sql
SELECT *,
SUM(salary) OVER(
ORDER BY emp_id
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) running_total
FROM employee;
```

---

# 10. FIRST_VALUE()

Gets **first value in ordered window**.

```sql
SELECT *,
FIRST_VALUE(salary) OVER(ORDER BY salary) AS lowest_salary
FROM employee;
```

Result

| name  | salary | lowest |
| ----- | ------ | ------ |
| Ali   | 50000  | 50000  |
| Ahmed | 60000  | 50000  |
| Sara  | 55000  | 50000  |

# 11. LAST_VALUE()

Last value depends on **window frame**.

Correct version:

```sql
SELECT *,
LAST_VALUE(salary) OVER(
ORDER BY salary
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) last_salary
FROM employee;
```

# 12. Running Sales Example

Orders table

```sql
CREATE TABLE orders(
order_id INT,
row_id INT,
sales INT
);
```

```sql
INSERT INTO orders VALUES
(1,1,100),
(2,1,200),
(3,1,300),
(4,1,150);
```

Running sales

```sql
SELECT
order_id,
sales,
SUM(sales) OVER(ORDER BY order_id,row_id) AS running_sales
FROM orders;
```

Result

| order | sales | running |
| ----- | ----- | ------- |
| 1     | 100   | 100     |
| 2     | 200   | 300     |
| 3     | 300   | 600     |
| 4     | 150   | 750     |

# 13. CTE (Common Table Expression)

CTE improves readability.

Example

```sql
WITH sales_cte AS
(
SELECT order_id, SUM(sales) total_sales
FROM orders
GROUP BY order_id
)

SELECT * FROM sales_cte;
```

# 14. Monthly Sales + Rolling Window

Orders table

```sql
CREATE TABLE orders(
order_date DATE,
sales INT
);
```

Example data

| date       | sales |
| ---------- | ----- |
| 2024-01-01 | 100   |
| 2024-02-01 | 200   |
| 2024-03-01 | 300   |
| 2024-04-01 | 400   |

Extract month/year

```sql
SELECT
DATEPART(YEAR,order_date) year_order,
DATEPART(MONTH,order_date) month_order,
SUM(sales) total_sales
FROM orders
GROUP BY
DATEPART(YEAR,order_date),
DATEPART(MONTH,order_date);
```

# 15. Rolling 3 Month Sales

```sql
WITH month_sales AS
(
SELECT
DATEPART(YEAR,order_date) year_order,
DATEPART(MONTH,order_date) month_order,
SUM(sales) total_sales
FROM orders
GROUP BY
DATEPART(YEAR,order_date),
DATEPART(MONTH,order_date)
)

SELECT
year_order,
month_order,
total_sales,

SUM(total_sales) OVER(
ORDER BY year_order,month_order
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) rolling_3_sales

FROM month_sales;
```

Example result

| month | sales | rolling |
| ----- | ----- | ------- |
| Jan   | 100   | 100     |
| Feb   | 200   | 300     |
| Mar   | 300   | 600     |
| Apr   | 400   | 900     |

# 16. EXISTS

Check if record exists.

```sql
SELECT *
FROM employee e
WHERE EXISTS
(
SELECT 1
FROM orders o
WHERE e.emp_id=o.order_id
);
```

# 17. NOT EXISTS

Opposite.

```sql
SELECT *
FROM employee e
WHERE NOT EXISTS
(
SELECT 1
FROM orders o
WHERE e.emp_id=o.order_id
);
```

# 18. Pivot / Unpivot

Pivot converts **rows → columns**.

Example

| month | sales |
| ----- | ----- |
| Jan   | 100   |
| Feb   | 200   |

Pivot

| Jan | Feb |
| --- | --- |
| 100 | 200 |

Used in reports.


# 19. Stored Procedure

Stored procedures are **saved SQL programs**.

Example

```sql
CREATE PROCEDURE GetEmployees
AS
SELECT * FROM employee;
```

Run

```sql
EXEC GetEmployees;
```

---

# 20. Indexes (Performance)

Indexes make queries **faster**.

Example

```sql
CREATE INDEX idx_employee_dept
ON employee(dept_id);
```

Database uses index to **search faster like book index**.
