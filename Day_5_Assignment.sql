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

SELECT * FROM Departments;
SELECT * FROM Employees;


-- Write a query to get location-wise count of employees in each department.
SELECT d.dept_name, d.location, count(*) as count FROM Departments d
inner join Employees e on d.dept_id=e.dept_id
group by d.dept_name, d.location 
;

-- Write a query to get average salary per job title.
SELECT job_title, avg(salary) as avg_salary 
FROM Employees
group by job_title;

-- Write a query to print department name and average salary of employees in that department
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM Departments d
LEFT JOIN Employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name
order by avg_salary asc;


-- Write a query to print department names where all employees have unique salaries.
SELECT d.dept_name FROM Departments d
 JOIN Employees e
ON d.dept_id = e.dept_id
group by d.dept_name
having COUNT(e.emp_id)= COUNT(DISTINCT e.salary);


-- Write a query to find departments with no employees.
SELECT * FROM Departments d
left join Employees e on d.dept_id=e.dept_id
where emp_name is null;

-- Write a query to find the top 3 highest-paid employees in Lahore.
SELECT e.emp_name, e.salary
FROM Employees e
JOIN Departments d 
ON e.dept_id = d.dept_id
WHERE d.location = 'Lahore'
ORDER BY e.salary DESC
LIMIT 3;

-- Write a query to print employees’ names whose department ID does not exist in the Departments table.
SELECT emp_name
FROM Employees
WHERE dept_id NOT IN (
    SELECT dept_id FROM Departments
);
