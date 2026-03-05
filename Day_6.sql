-- 1. Reset Tables
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 2. Create Tables
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name TEXT
);
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name TEXT,
    salary INT,
    dept_id INT,
    manager_id INT
);

-- 3. Insert Sample Data
INSERT INTO departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Sales');
INSERT INTO employees VALUES
(1,'Ali',50000,1,NULL),
(2,'Ahmed',60000,2,1),
(3,'Sara',55000,2,1),
(4,'Bilal',40000,3,2),
(5,'Hina',70000,3,2);

-- 4. View Tables
SELECT * FROM departments;
SELECT * FROM employees;

-- 5. JOIN Example
SELECT 
    dept_name,
    COUNT(*) AS total_employees
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY dept_name;

-- 6. HAVING Clause
SELECT 
    dept_id,
    COUNT(*) AS total_employees
FROM employees
GROUP BY dept_id
HAVING COUNT(*) > 1;

-- 7. Self Join (Employee → Manager)
SELECT 
    e1.emp_name AS employee,
    e2.emp_name AS manager
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.emp_id;

-- 8. Employees Earning More Than Manager
SELECT 
    e1.emp_name,
    e1.salary,
    e2.emp_name AS manager,
    e2.salary
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.emp_id
WHERE e1.salary > e2.salary;

-- 9. STRING_AGG Function
SELECT 
    dept_id,
    STRING_AGG(emp_name, ', ') AS employees
FROM employees
GROUP BY dept_id;

-- 10. Orders Table (Date Practice)
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    ship_date DATE
);

-- Insert data
INSERT INTO orders VALUES
(1,'2024-01-01','2024-01-05'),
(2,'2024-02-01','2024-02-03');

-- 11. Date Difference
SELECT 
    order_id,
    ship_date - order_date AS delivery_time
FROM orders;


-- 12. Add Time to Dates
SELECT 
    order_date,
    order_date + INTERVAL '5 days'  AS days_added,
    order_date + INTERVAL '1 week'  AS week_added,
    order_date + INTERVAL '1 month' AS month_added
FROM orders;

-- 13. Extract Date Parts
SELECT 
    order_date,
    EXTRACT(YEAR FROM order_date)  AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(DAY FROM order_date)   AS day
FROM orders;

-- 14. CASE Statement
SELECT 
    emp_name,
    salary,
    CASE 
        WHEN salary <= 50000 THEN 'LOW'
        WHEN salary > 50000 AND salary <= 55000 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS salary_slab
FROM employees;

-- THE END
