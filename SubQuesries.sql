-- Part 1: Database Setup

DROP DATABASE IF EXISTS SubQueries_assignment;
CREATE DATABASE SubQueries_assignment;
USE SubQueries_assignment;

-- 1. Create and Insert Department Data
CREATE TABLE Departments (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO Departments VALUES
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bengaluru'),
('D05', 'IT', 'Hyderabad');

-- 2. Create and Insert Employee Data
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(10),
    salary INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Employees VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

-- 3. Create and Insert Sales Data
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

INSERT INTO Sales VALUES
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');

-- Part 2: Assignment Solutions
-- Here are the queries for the questions listed in your PDF.

-- ====================
-- Basic Level
-- ====================

-- 1. Retrieve the names of employees who earn more than the average salary of all employees.
SELECT name 
FROM Employees 
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- 2. Find the employees who belong to the department with the highest average salary.
SELECT * FROM Employees 
WHERE department_id = (
    SELECT department_id 
    FROM Employees 
    GROUP BY department_id 
    ORDER BY AVG(salary) DESC 
    LIMIT 1
);

-- 3. List all employees who have made at least one sale.
SELECT * FROM Employees 
WHERE emp_id IN (SELECT DISTINCT emp_id FROM Sales);

-- 4. Find the employee with the highest sale amount.
SELECT * FROM Employees 
WHERE emp_id = (
    SELECT emp_id 
    FROM Sales 
    ORDER BY sale_amount DESC 
    LIMIT 1
);

-- 5. Retrieve the names of employees whose salaries are higher than Shubham's salary.
SELECT name 
FROM Employees 
WHERE salary > (SELECT salary FROM Employees WHERE name = 'Shubham');

-- ====================
-- Intermediate Level
-- ====================

-- 1. Find employees who work in the same department as Abhishek.
SELECT * FROM Employees 
WHERE department_id = (SELECT department_id FROM Employees WHERE name = 'Abhishek')
AND name != 'Abhishek';

-- 2. List departments that have at least one employee earning more than 60,000.
SELECT * FROM Departments 
WHERE department_id IN (SELECT DISTINCT department_id FROM Employees WHERE salary > 60000);

-- 3. Find the department name of the employee who made the highest sale.
SELECT department_name 
FROM Departments 
WHERE department_id = (
    SELECT department_id 
    FROM Employees 
    WHERE emp_id = (
        SELECT emp_id FROM Sales ORDER BY sale_amount DESC LIMIT 1
    )
);

-- 4. Retrieve employees who have made sales greater than the average sale amount.
SELECT e.name, s.sale_amount
FROM Employees e
JOIN Sales s ON e.emp_id = s.emp_id
WHERE s.sale_amount > (SELECT AVG(sale_amount) FROM Sales);

-- 5. Find the total sales made by employees who earn more than the average salary.
SELECT SUM(sale_amount) AS Total_Sales
FROM Sales 
WHERE emp_id IN (
    SELECT emp_id 
    FROM Employees 
    WHERE salary > (SELECT AVG(salary) FROM Employees)
);

-- ====================
-- Advanced Level
-- ====================

-- 1. Find employees who have not made any sales.
SELECT * FROM Employees 
WHERE emp_id NOT IN (SELECT DISTINCT emp_id FROM Sales);

-- 2. List departments where the average salary is above ₹55,000.
SELECT d.department_name, AVG(e.salary) as avg_salary
FROM Departments d
JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING AVG(e.salary) > 55000;

-- 3. Retrieve department names where the total sales exceed ₹10,000.
SELECT d.department_name 
FROM Departments d
JOIN Employees e ON d.department_id = e.department_id
JOIN Sales s ON e.emp_id = s.emp_id
GROUP BY d.department_name
HAVING SUM(s.sale_amount) > 10000;

-- 4. Find the employee who has made the second-highest sale.
SELECT e.name, s.sale_amount
FROM Employees e
JOIN Sales s ON e.emp_id = s.emp_id
WHERE s.sale_amount = (
    SELECT MAX(sale_amount) 
    FROM Sales 
    WHERE sale_amount < (SELECT MAX(sale_amount) FROM Sales)
);

-- 5. Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
SELECT name 
FROM Employees 

WHERE salary > (SELECT MAX(sale_amount) FROM Sales);
