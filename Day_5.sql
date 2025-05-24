-- Table Creation

CREATE TABLE Departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    budget INT
);

CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    job_title VARCHAR(100),
    hire_date DATE,
    salary INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- Data Insertion
INSERT INTO Employees (emp_name, job_title, hire_date, salary, dept_id) VALUES
('Ayesha Khan', 'Data Analyst', '2023-07-15', 80000, 1),
('Ali Raza', 'Machine Learning Engineer', '2024-02-10', 120000, 1),
('Fatima Noor', 'Backend Developer', '2022-11-01', 95000, 2),
('Bilal Ahmed', 'Frontend Developer', '2023-01-12', 88000, 2),
('Zara Sheikh', 'HR Specialist', '2021-05-20', 65000, 3),
('Hassan Javed', 'DevOps Engineer', '2023-03-25', 105000, 2),
('Mehwish Ali', 'Business Analyst', '2022-09-30', 90000, 1),
('Saad Rehman', 'Project Manager', '2020-06-18', 130000, 3),
('Nimra Fatima', 'UI/UX Designer', '2024-01-05', 82000, 2),
('Umer Farooq', 'QA Engineer', '2022-04-11', 78000, 2);

INSERT INTO Departments (dept_name, location, budget) VALUES
('Data Science', 'Lahore', 500000),
('Software Engineering', 'Karachi', 750000),
('Human Resources', 'Islamabad', 300000),
('Marketing', 'Lahore', 400000),
('Finance', 'Karachi', 600000),
('Product Management', 'Islamabad', 650000),
('Cybersecurity', 'Rawalpindi', 550000),
('Quality Assurance', 'Multan', 350000),
('Customer Support', 'Faisalabad', 250000),
('AI Research', 'Lahore', 800000);

-- View Table
SELECT * FROM employees;
SELECT * FROM departments;

/*
Join se pehle wala table hamesha left table hota hai  
Join ke baad wala table hamesha right table hota hai  

This rule applies to all joins — LEFT, RIGHT, INNER, etc.
*/

-- 1. INNER JOIN : Returns only matching rows from both tables.
SELECT e.emp_id, e.emp_name, e.salary, d.location
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;


-- 2. LEFT JOIN : Returns all rows from the left table and matched rows from the right table.
SELECT e.emp_id, e.emp_name, e.job_title, d.dept_name
FROM departments d
LEFT JOIN employees e
ON e.dept_id = d.dept_id;

-- 3. RIGHT JOIN : Returns all rows from the right table and matched rows from the left table.
SELECT e.emp_id, e.emp_name, e.job_title, d.dept_name
FROM departments d
RIGHT JOIN employees e
ON e.dept_id = d.dept_id;


-- 4. FULL JOIN (or FULL OUTER JOIN) : Returns all rows when there is a match in either left or right table.
SELECT *
FROM employees e
FULL JOIN departments d
ON e.dept_id = d.dept_id;

-- 5. CROSS JOIN : Returns the Cartesian product of both tables.
SELECT *
FROM employees e
CROSS JOIN departments d;
















