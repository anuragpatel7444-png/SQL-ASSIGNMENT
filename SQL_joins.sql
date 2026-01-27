DROP DATABASE IF EXISTS mts_db;

-- 1. Database Create 
CREATE DATABASE mts_db;
USE mts_db;

-- 2. Create & Insert Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);
INSERT INTO Customers VALUES
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Robert White', 'Houston'),
(5, 'Nancy Miller', 'Miami');

-- 3. Create & Insert Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount INT
);
INSERT INTO Orders VALUES
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 6, '2024-10-12', 400);

-- 4. Create & Insert Payments
CREATE TABLE Payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    CustomerID INT,
    PaymentDate DATE,
    Amount INT
);
INSERT INTO Payments VALUES
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);

-- 5. Create & Insert Employees (Updated Section)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    ManagerID INT
);
-- Note: NULL bina quotes ke likha hai
INSERT INTO Employees (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'Alex Green', NULL),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'David Kim', 2),
(5, 'Eva Smith', 2);

-------------------------------------------
-- SOLUTIONS TO QUESTIONS
-------------------------------------------

-- Question 1: Retrieve all customers who have placed at least one order.
SELECT DISTINCT c.*
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- Question 2: Retrieve all customers and their orders, including those with no orders.
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.Amount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- Question 3: Retrieve all orders and their customers, including unknown customers.
SELECT o.OrderID, o.Amount, c.CustomerName
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- Question 4: Display all customers and orders, whether matched or not (Full Outer Join Simulation).
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
UNION
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- Question 5: Find customers who have not placed any orders.
SELECT c.*
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- Question 6: Retrieve customers who made payments but did not place any orders.
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
INNER JOIN Payments p
ON c.CustomerID = p.CustomerID
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- Question 7: Generate a list of all possible combinations (Cartesian Product).
SELECT c.CustomerName, o.OrderID
FROM Customers c
CROSS JOIN Orders o;

-- Question 8: Show all customers along with order and payment amounts.
SELECT c.CustomerName,
       o.Amount AS OrderAmount,
       p.Amount AS PaymentAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p
ON c.CustomerID = p.CustomerID;

-- Question 9: Retrieve all customers who have BOTH placed orders and made payments.
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN Payments p
ON c.CustomerID = p.CustomerID;

-- Check Employees Table
SELECT * FROM Employees;
