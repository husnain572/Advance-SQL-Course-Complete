-- ===========================
-- 🚧 SCHEMA & DATA CREATION
-- ===========================

-- Employee Table
CREATE TABLE employee (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_id INT,
    manager_id INT,
    salary NUMERIC(10,2),
    emp_age INT
);

INSERT INTO employee (emp_name, dept_id, manager_id, salary, emp_age) VALUES
    ('Ali', 1, NULL, 50000, 30),
    ('Sara', 1, 1, 55000, 28),
    ('Ahmed', 2, 1, 48000, 32),
    ('Fatima', 2, 3, 47000, 26),
    ('Usman', 3, 2, 60000, 35),
    ('Ayesha', 3, 2, 45000, 27);

-- Department Table
CREATE TABLE dept (
    dep_id INT PRIMARY KEY,
    dep_name VARCHAR(100)
);

INSERT INTO dept (dep_id, dep_name) VALUES
    (1, 'Sales'),
    (2, 'HR'),
    (3, 'IT');

-- Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    sub_category VARCHAR(50),
    city VARCHAR(100),
    order_date DATE,
    ship_date DATE,
    profit NUMERIC(10,2)
);

INSERT INTO orders (sub_category, city, order_date, ship_date, profit) VALUES
    ('Phones', 'Karachi', '2024-01-01', '2024-01-05', 150),
    ('Chairs', 'Lahore', '2024-01-10', '2024-01-17', 75),
    ('Binders', 'Karachi', '2024-02-01', '2024-02-06', 250),
    ('Tables', 'Lahore', '2024-03-03', '2024-03-10', -50),
    ('Furnishings', 'Islamabad', '2024-03-15', '2024-03-20', 420),
    ('Phones', 'Islamabad', '2024-04-01', '2024-04-04', 380);

-- Returns Table
CREATE TABLE returns (
    return_id SERIAL PRIMARY KEY,
    order_id INT,
    return_reason VARCHAR(100)
);

INSERT INTO returns (order_id, return_reason) VALUES
    (1, 'others'),
    (1, 'bad quanlity'),
    (1, 'wrong item'),
    (2, 'bad quanlity'),
    (4, 'wrong item');

-- ===========================
-- 🔍 BASIC SELECTS
-- ===========================
SELECT * FROM employee;
SELECT * FROM dept;
SELECT * FROM orders;
SELECT * FROM returns;

-- ===========================
-- 🧮 CTE + JOIN + FILTER
-- ===========================
WITH employee_salary AS (
    SELECT e.emp_name, e.salary, d.dep_name
    FROM employee e
    LEFT JOIN dept d ON e.dept_id = d.dep_id
)
SELECT * FROM employee_salary
WHERE salary > 50000;

-- ===========================
-- 🧠 CASE STATEMENT EXAMPLE
-- ===========================
INSERT INTO employee (emp_name, dept_id, manager_id, salary, emp_age) 
VALUES ( 'Sajjad', 2, 1, 28000, 24 );

SELECT *,
    CASE 
        WHEN salary BETWEEN 25000 AND 29999 THEN 'Intern'
        WHEN salary BETWEEN 30000 AND 34999 THEN 'Associate Engineer'
        WHEN salary BETWEEN 40000 AND 50000 THEN 'Senior'
        WHEN salary BETWEEN 50001 AND 100000 THEN 'Manager'
        ELSE 'CEO'
    END AS salary_slab
FROM employee;

-- ===========================
-- 📅 DATE & TIME FUNCTIONS
-- ===========================
SELECT CURRENT_TIME;
SELECT CURRENT_DATE;
SELECT NOW();

SELECT *,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    EXTRACT(DAY FROM order_date) AS order_day,
    EXTRACT(WEEK FROM order_date) AS order_week,
    EXTRACT(DOW FROM order_date) AS day_of_week,
    EXTRACT(QUARTER FROM order_date) AS quarter
FROM orders;

-- ===========================
-- 📆 DOB UPDATE FROM AGE
-- ===========================
ALTER TABLE employee ADD COLUMN dob DATE;
UPDATE employee SET dob = CURRENT_DATE - (emp_age || ' years')::INTERVAL;
SELECT * FROM employee;

-- ===========================
-- 🚚 DELIVERY TIME CALCULATION
-- ===========================
SELECT sub_category, (ship_date - order_date) AS delivery_days
FROM orders;

SELECT *, 
    EXTRACT(WEEK FROM ship_date) - EXTRACT(WEEK FROM order_date) AS week_diff
FROM orders;

SELECT *, 
    order_date + INTERVAL '5 days' AS order_date_5,
    order_date + INTERVAL '1 week' AS order_date_week_5,
    order_date - INTERVAL '5 days' AS order_date_week_5_minus
FROM orders;

-- ===========================
-- 👨‍💼 MANAGER ID UPDATE
-- ===========================
UPDATE employee SET manager_id = 3 WHERE manager_id IS NULL;

-- ===========================
-- 🧑‍🤝‍🧑 STRING AGGREGATION
-- ===========================
SELECT dept_id, 
    STRING_AGG(emp_name, ',' ORDER BY salary DESC) AS list_of_emp
FROM employee 
GROUP BY dept_id;

-- ===========================
-- 🧮 DISTINCT SALARY = COUNT
-- ===========================
SELECT d.dep_name, e.dept_id
FROM employee e
LEFT JOIN dept d ON e.dept_id = d.dep_id
GROUP BY d.dep_name, e.dept_id
HAVING COUNT(DISTINCT salary) = COUNT(1);
