# Dummy Data Creation

First, we create a simple `employees` table that will be used to demonstrate **subqueries, CTEs, and window functions**.

```sql
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
```

Insert some dummy data:

```sql
INSERT INTO employees VALUES
(1,'Ali','IT',70000),
(2,'Ahmed','IT',80000),
(3,'Sara','HR',60000),
(4,'Hina','HR',65000),
(5,'Usman','Finance',90000),
(6,'Hamza','Finance',90000),
(7,'Zara','IT',75000);
```

The table will look like this:

| emp_id | name  | department | salary |
| ------ | ----- | ---------- | ------ |
| 1      | Ali   | IT         | 70000  |
| 2      | Ahmed | IT         | 80000  |
| 3      | Sara  | HR         | 60000  |
| 4      | Hina  | HR         | 65000  |
| 5      | Usman | Finance    | 90000  |
| 6      | Hamza | Finance    | 90000  |
| 7      | Zara  | IT         | 75000  |


# Subqueries

A **subquery** is a query written inside another query.
The result of the inner query is used by the outer query.

### Basic Structure

```sql
SELECT *
FROM table
WHERE column = (
    SELECT something
    FROM table
);
```


## Example 1

### Find the employees with the highest salary

```sql
SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);
```

### Inner Query

```sql
SELECT MAX(salary)
FROM employees;
```

Result:

```
90000
```

This value is then used by the outer query:

```sql
SELECT *
FROM employees
WHERE salary = 90000;
```

Result:

| name  | salary |
| ----- | ------ |
| Usman | 90000  |
| Hamza | 90000  |

---

## Example 2

### Find employees earning more than the average salary

```sql
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

# CTE (Common Table Expression)

A **Common Table Expression (CTE)** is a temporary result set that can be referenced within a query.

It helps make complex queries **more readable and organized**.

### Syntax

```sql
WITH cte_name AS (
    query
)
SELECT *
FROM cte_name;
```

## Example 1

### Calculate the total salary for each department

```sql
WITH dept_salary AS (
    SELECT department,
           SUM(salary) AS total_salary
    FROM employees
    GROUP BY department
)

SELECT *
FROM dept_salary;
```

Result:

| department | total_salary |
| ---------- | ------------ |
| IT         | 225000       |
| HR         | 125000       |
| Finance    | 180000       |


## Example 2

### Find the department with the highest total salary

```sql
WITH dept_salary AS (
    SELECT department,
           SUM(salary) AS total_salary
    FROM employees
    GROUP BY department
)

SELECT *
FROM dept_salary
WHERE total_salary = (
    SELECT MAX(total_salary)
    FROM dept_salary
);
```


# Window Functions

Window functions perform **calculations across a set of rows** without collapsing the result like `GROUP BY`.

### Normal Aggregate Function

```sql
SELECT department, SUM(salary)
FROM employees
GROUP BY department;
```

This reduces the number of rows.



### Window Function Example

```sql
SELECT name,
       department,
       salary,
       SUM(salary) OVER(PARTITION BY department)
FROM employees;
```

Here, the number of rows **remains the same**, but we get aggregated information.

# ROW_NUMBER()

`ROW_NUMBER()` assigns a **unique sequential number to each row**.

### Example

```sql
SELECT name,
       department,
       salary,
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM employees;
```

Result:

| name  | salary | row_num |
| ----- | ------ | ------- |
| Usman | 90000  | 1       |
| Hamza | 90000  | 2       |
| Ahmed | 80000  | 3       |
| Zara  | 75000  | 4       |
| Ali   | 70000  | 5       |

Even if two rows have the same value, `ROW_NUMBER()` still assigns different numbers.

# RANK()

`RANK()` assigns the same rank to equal values, but **skips ranks after ties**.

### Example

```sql
SELECT name,
       salary,
       RANK() OVER(ORDER BY salary DESC) AS rank
FROM employees;
```

Result:

| name  | salary | rank |
| ----- | ------ | ---- |
| Usman | 90000  | 1    |
| Hamza | 90000  | 1    |
| Ahmed | 80000  | 3    |

Notice that **rank 2 is skipped**.


# DENSE_RANK()

`DENSE_RANK()` also assigns the same rank to equal values, but **does not skip ranks**.

### Example

```sql
SELECT name,
       salary,
       DENSE_RANK() OVER(ORDER BY salary DESC) AS rank
FROM employees;
```

Result:

| name  | salary | rank |
| ----- | ------ | ---- |
| Usman | 90000  | 1    |
| Hamza | 90000  | 1    |
| Ahmed | 80000  | 2    |


# PARTITION BY (Important)

`PARTITION BY` divides data into groups before applying the window function.

### Example: Department-wise ranking

```sql
SELECT name,
       department,
       salary,
       ROW_NUMBER() OVER(
           PARTITION BY department
           ORDER BY salary DESC
       ) AS rank
FROM employees;
```

Each department will have its **own ranking**.

# Interview-Level Question

### Find the highest-paid employee in each department

```sql
SELECT *
FROM (
    SELECT name,
           department,
           salary,
           ROW_NUMBER() OVER(
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rn
    FROM employees
) t
WHERE rn = 1;
```

# Window Function with CTE

A cleaner and more readable approach:

```sql
WITH ranked_emp AS (
    SELECT name,
           department,
           salary,
           ROW_NUMBER() OVER(
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rn
    FROM employees
)

SELECT *
FROM ranked_emp
WHERE rn = 1;
```


# Real Interview Question

### Find the second highest salary

```sql
SELECT *
FROM (
    SELECT name,
           salary,
           DENSE_RANK() OVER(ORDER BY salary DESC) rnk
    FROM employees
) t
WHERE rnk = 2;
```

# Cheat Sheet

### Subquery

A query written inside another query.

```sql
SELECT *
FROM table
WHERE column = (SELECT ...)
```

### CTE

Temporary result set defined at the beginning of a query.

```sql
WITH temp_table AS (
    SELECT ...
)
SELECT *
FROM temp_table;
```

### Window Functions

| Function   | Behavior                                    |
| ---------- | ------------------------------------------- |
| ROW_NUMBER | Assigns a unique number to each row         |
| RANK       | Same rank for ties but skips numbers        |
| DENSE_RANK | Same rank for ties without skipping numbers |

