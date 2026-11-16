-- ============================================================================
-- SQL & RELATIONAL DATABASE DESIGN | STUDENT ASSIGNMENT PACK
-- Student: İsmayıl İsmayılzadə
-- Group: 844i
-- DBMS: SQLite (DB Browser for SQLite 3.13.1)
-- ============================================================================

PRAGMA foreign_keys = ON;

-- ============================================================================
-- PART I: REQUIRED DATABASE SETUP (TABLES & REFERENCE DATA)
-- ============================================================================

CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INTEGER
);

CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    Product VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    BirthDate DATE,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    ManagerID INTEGER NULL,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    ProductID INTEGER,
    CustomerID INTEGER,
    SalesPersonID INTEGER,
    OrderDate DATE,
    ShipDate DATE NULL,
    OrderStatus VARCHAR(30),
    ShipAddress VARCHAR(150) NULL,
    BillAddress VARCHAR(150) NULL,
    Quantity INTEGER,
    Sales DECIMAL(10,2),
    CreationTime DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SalesPersonID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Country, Score) VALUES
(1, 'Ayla', 'Karimova', 'Azerbaijan', 720),
(2, 'John', 'Miller', 'USA', 450),
(3, 'Emma', 'Schmidt', 'Germany', 860),
(4, 'Sara', 'Martin', 'France', 280),
(5, 'Lukas', 'Weber', 'Germany', 550),
(6, 'Noah', 'Adams', 'USA', 610),
(7, 'Lea', 'Fischer', 'Germany', 680),
(8, 'Sofia', 'Rossi', 'Italy', 700),
(9, 'Ali', 'Hasanov', 'Azerbaijan', 330);

INSERT INTO Products (ProductID, Product, Category, Price) VALUES
(101, 'Wireless Mouse', 'Electronics', 55.00),
(102, 'Office Chair', 'Furniture', 230.00),
(103, 'Laptop', 'Electronics', 850.00),
(104, 'Notebook', 'Stationery', 12.00),
(105, 'Smart Phone', 'Electronics', 420.00),
(106, 'Standing Desk', 'Furniture', 380.00),
(107, 'USB Hub', 'Electronics', 45.00),
(108, 'Desk Lamp', 'Furniture', 65.00);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID) VALUES
(12, 'Maya', 'Brown', 'Sales', '1990-07-09', 'Female', 2400.00, NULL),
(11, 'David', 'Lee', 'Sales', '1987-05-14', 'Male', 2200.00, 12),
(13, 'Alex', 'Green', 'Support', '1994-11-21', 'Male', 1900.00, 12),
(14, 'Omar', 'Ali', 'Sales', '1995-02-17', 'Male', 2100.00, 12),
(15, 'Nina', 'Stone', 'Sales', '1998-08-03', 'Female', 2000.00, 12);

INSERT INTO Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime) VALUES
(201, 101, 1, 11, '2026-10-04', '2026-10-06', 'Delivered', '10 Nizami St, Baku', '10 Nizami St, Baku', 2, 110.00, '2026-10-04 10:00:00'),
(202, 103, 3, 12, '2026-10-08', '2026-10-18', 'Shipped', '22 Oak St, Berlin', '22 Oak St, Berlin', 1, 850.00, '2026-10-08 10:00:00'),
(203, 102, 2, 11, '2026-10-12', NULL, 'Pending', NULL, '45 Main St, New York', 1, 230.00, '2026-10-12 10:00:00'),
(204, 105, 5, 12, '2026-10-15', '2026-10-19', 'Delivered', '16 Park Rd, Munich', '16 Park Rd, Munich', 1, 420.00, '2026-10-15 10:00:00'),
(205, 103, 3, 12, '2026-10-20', '2026-10-22', 'Delivered', '22 Oak St, Berlin', '22 Oak St, Berlin', 8, 6800.00, '2026-10-20 10:00:00'),
(206, 105, 2, 11, '2026-10-21', '2026-10-23', 'Delivered', '45 Main St, New York', '9 Pine St, Boston', 3, 1260.00, '2026-10-21 10:00:00'),
(207, 102, 6, 14, '2026-10-22', '2026-10-24', 'Delivered', '31 Oak St, Boston', '31 Oak St, Boston', 4, 920.00, '2026-10-22 10:00:00'),
(208, 101, 4, 11, '2026-10-23', NULL, 'Pending', NULL, '8 Rue Lyon, Paris', 2, 110.00, '2026-10-23 10:00:00'),
(209, 106, 1, 14, '2026-10-24', '2026-10-27', 'Delivered', '10 Nizami St, Baku', '10 Nizami St, Baku', 2, 760.00, '2026-10-24 10:00:00'),
(210, 103, 6, 14, '2026-10-25', NULL, 'Cancelled', '31 Oak St, Boston', '31 Oak St, Boston', 2, 1700.00, '2026-10-25 10:00:00'),
(211, 104, 5, 11, '2026-10-26', '2026-10-28', 'Delivered', '16 Park Rd, Munich', '16 Park Rd, Munich', 10, 120.00, '2026-10-26 10:00:00'),
(212, 105, 3, 12, '2026-10-27', NULL, 'Pending', NULL, '22 Oak St, Berlin', 2, 840.00, '2026-10-27 10:00:00'),
(213, 107, 2, 11, '2026-10-28', '2026-10-30', 'Shipped', '45 Main St, New York', '45 Main St, New York', 3, 135.00, '2026-10-28 10:00:00'),
(214, 103, 8, 14, '2026-10-29', '2026-11-01', 'Delivered', '18 Via Roma, Milan', '18 Via Roma, Milan', 1, 850.00, '2026-10-29 10:00:00'),
(215, 106, 5, 12, '2026-10-30', NULL, 'Pending', '16 Park Rd, Munich', '16 Park Rd, Munich', 1, 380.00, '2026-10-30 10:00:00'),
(216, 101, 1, 11, '2026-11-02', '2026-11-04', 'Delivered', '10 Nizami St, Baku', '10 Nizami St, Baku', 1, 55.00, '2026-11-02 10:00:00'),
(217, 102, 7, 14, '2026-11-03', '2026-11-05', 'Shipped', '9 River St, Berlin', '9 River St, Berlin', 1, 230.00, '2026-11-03 10:00:00'),
(218, 105, 6, 14, '2026-11-04', NULL, 'Pending', '31 Oak St, Boston', NULL, 1, 420.00, '2026-11-04 10:00:00'),
(219, 103, 3, 12, '2026-11-05', '2026-11-06', 'Shipped', '22 Oak St, Berlin', '22 Oak St, Berlin', 1, 850.00, '2026-11-05 10:00:00'),
(220, 104, 2, 11, '2026-11-06', '2026-11-07', 'Delivered', '45 Main St, New York', '45 Main St, New York', 5, 60.00, '2026-11-06 10:00:00'),
(221, 107, 6, 14, '2026-10-28', NULL, 'Shipped', '31 Oak St, Boston', '31 Oak St, Boston', 1, 45.00, '2026-10-28 10:00:00'),
(222, 102, 4, 11, '2026-10-31', '2026-10-30', 'Shipped', '8 Rue Lyon, Paris', '8 Rue Lyon, Paris', 1, 230.00, '2026-10-31 10:00:00'),
(223, 102, 2, 11, '2026-10-29', '2026-10-31', 'Delivered', '45 Main St, New York', '45 Main St, New York', 1, 230.00, '2026-10-29 10:00:00'),
(224, 101, 3, 12, '2026-11-02', NULL, 'Pending', '22 Oak St, Berlin', '22 Oak St, Berlin', 2, 110.00, '2026-11-02 10:00:00');

-- ============================================================================
-- PART I: BASIC SQL (TEN FOUNDATIONAL TASKS: B01 - B10)
-- ============================================================================

-- B01. Explore a table: Retrieve all columns, then only FirstName, LastName, Country
SELECT * FROM Customers;

SELECT FirstName, LastName, Country
FROM Customers;

-- B02. Filter by country: Display customers from Germany
SELECT CustomerID, FirstName, LastName, Country
FROM Customers
WHERE Country = 'Germany';

-- B03. Combine conditions: Score >= 300 and Country in Germany or France
SELECT CustomerID, FirstName, LastName, Country, Score
FROM Customers
WHERE Score >= 300
  AND Country IN ('Germany', 'France');

-- B04. Sort products: Most expensive to least expensive
SELECT ProductID, Product, Category, Price
FROM Products
ORDER BY Price DESC;

-- B05. Search within a range: Price between 50 and 300 inclusive
SELECT Product, Price
FROM Products
WHERE Price BETWEEN 50 AND 300;

-- B06. Search text patterns: Product name contains 'Phone'
SELECT Product, Category
FROM Products
WHERE Product LIKE '%Phone%';

-- B07. Find distinct values: Unique Category in alphabetical order
SELECT DISTINCT Category
FROM Products
ORDER BY Category ASC;

-- B08. Connect customer orders: Each OrderID with customer first and last name
SELECT o.OrderID, c.FirstName, c.LastName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;

-- B09. Summarize orders: Order count and total Sales per OrderStatus, sorted by total Sales DESC
SELECT OrderStatus,
       COUNT(OrderID) AS OrderCount,
       SUM(Sales) AS TotalSales
FROM Orders
GROUP BY OrderStatus
ORDER BY TotalSales DESC;

-- ============================================================================
-- B10. Make a safe data change (EXECUTE ONLY IN PRACTICE COPY: SalesDB_Practice)
-- ============================================================================
INSERT INTO Products (ProductID, Product, Category, Price)
VALUES (901, 'Webcam HD', 'Electronics', 80.00);

UPDATE Products
SET Price = 95.00
WHERE ProductID = 901;

SELECT * FROM Products
WHERE ProductID = 901;

DELETE FROM Products
WHERE ProductID = 901;

-- ============================================================================
-- PART II: BUSINESS SCENARIOS (SCENARIOS 1, 2, AND 3)
-- ============================================================================

-- ============================================================================
-- SCENARIO 1: CUSTOMER CAMPAIGN SEGMENTATION (RUN ON CLEAN SalesDB)
-- ============================================================================

-- 1.1 Show all customers sorted by Score descending
SELECT CustomerID, FirstName, LastName, Country, Score
FROM Customers
ORDER BY Score DESC;

-- 1.2 Filter customers from Germany or France with Score >= 500
SELECT CustomerID, FirstName, LastName, Country, Score
FROM Customers
WHERE Country IN ('Germany', 'France')
  AND Score >= 500;

-- 1.3 Find customers whose Score is between 400 and 750 inclusive
SELECT CustomerID, FirstName, LastName, Country, Score
FROM Customers
WHERE Score BETWEEN 400 AND 750;

-- 1.4 Find customers whose FirstName starts with 'A' or LastName ends with 'i'
SELECT CustomerID, FirstName, LastName, Country, Score
FROM Customers
WHERE FirstName LIKE 'A%'
   OR LastName LIKE '%i';

-- 1.5 Display distinct countries represented in Customers
SELECT DISTINCT Country
FROM Customers
ORDER BY Country ASC;

-- 1.6 Count customers per country and display only countries with at least 2 customers
SELECT Country, COUNT(CustomerID) AS CustomerCount
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) >= 2;

-- 1.7 Show all customers together with their OrderID and Sales (including zero orders)
SELECT c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.Sales
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 1.8 Show only customers who have placed zero orders
SELECT c.CustomerID, c.FirstName, c.LastName, c.Country, c.Score
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- ============================================================================
-- SCENARIO 2: PRODUCT CATALOG & INVENTORY MAINTENANCE
-- ============================================================================

-- 2.1 Show all products sorted by Category ascending and Price descending (RUN ON SalesDB)
SELECT ProductID, Product, Category, Price
FROM Products
ORDER BY Category ASC, Price DESC;

-- 2.2 Show products in Electronics or Furniture priced between 50 and 450 (RUN ON SalesDB)
SELECT ProductID, Product, Category, Price
FROM Products
WHERE Category IN ('Electronics', 'Furniture')
  AND Price BETWEEN 50 AND 450;

-- 2.3 Show products whose name contains 'Desk' or 'Mouse' (RUN ON SalesDB)
SELECT ProductID, Product, Category, Price
FROM Products
WHERE Product LIKE '%Desk%'
   OR Product LIKE '%Mouse%';

-- 2.4 Count products and calculate total/average price per Category (RUN ON SalesDB)
SELECT Category,
       COUNT(ProductID) AS ProductCount,
       SUM(Price) AS TotalPrice,
       ROUND(AVG(Price), 2) AS AveragePrice
FROM Products
GROUP BY Category;

-- --- PRACTICE COPY OPERATIONS BELOW (RUN ONLY ON SalesDB_Practice) ---

-- 2.5 Add a nullable StockQuantity integer column to Products
ALTER TABLE Products
ADD COLUMN StockQuantity INTEGER NULL;

-- 2.6 Insert one new product (ProductID = 109) with StockQuantity populated
INSERT INTO Products (ProductID, Product, Category, Price, StockQuantity)
VALUES (109, 'Wireless Keyboard', 'Electronics', 75.00, 30);

-- 2.7 Update Price and StockQuantity for selected products using primary keys
UPDATE Products
SET Price = 60.00, StockQuantity = 50
WHERE ProductID = 101;

UPDATE Products
SET StockQuantity = 15
WHERE ProductID = 102;

SELECT * FROM Products WHERE ProductID IN (101, 102, 109);

-- ============================================================================
-- SCENARIO 3: ORDER FULFILLMENT & DATA CLEANUP
-- ============================================================================

-- 3.1 List all orders with OrderStatus, OrderDate, ShipDate, Quantity, and Sales (RUN ON SalesDB)
SELECT OrderID, OrderStatus, OrderDate, ShipDate, Quantity, Sales
FROM Orders;

-- 3.2 Find orders whose status is Pending or Cancelled (RUN ON SalesDB)
SELECT OrderID, CustomerID, ProductID, OrderStatus, OrderDate, Sales
FROM Orders
WHERE OrderStatus IN ('Pending', 'Cancelled');

-- 3.3 Find orders placed between '2026-10-20' and '2026-11-02' inclusive (RUN ON SalesDB)
SELECT OrderID, CustomerID, OrderDate, OrderStatus, Sales
FROM Orders
WHERE OrderDate BETWEEN '2026-10-20' AND '2026-11-02';

-- 3.4 Find orders where ShipDate is NULL or ShipAddress is NULL (RUN ON SalesDB)
SELECT OrderID, OrderStatus, OrderDate, ShipDate, ShipAddress
FROM Orders
WHERE ShipDate IS NULL
   OR ShipAddress IS NULL;

-- 3.5 Find orders where ShipAddress differs from BillAddress (including one-sided NULL) (RUN ON SalesDB)
SELECT OrderID, ShipAddress, BillAddress
FROM Orders
WHERE ShipAddress <> BillAddress
   OR (ShipAddress IS NULL AND BillAddress IS NOT NULL)
   OR (ShipAddress IS NOT NULL AND BillAddress IS NULL);

-- 3.6 Flag audit anomalies: ShipDate < OrderDate OR (OrderStatus = 'Shipped' AND ShipDate IS NULL) (RUN ON SalesDB)
SELECT OrderID, OrderDate, ShipDate, OrderStatus
FROM Orders
WHERE ShipDate < OrderDate
   OR (OrderStatus = 'Shipped' AND ShipDate IS NULL);

-- 3.7 Count orders and sum Sales per OrderStatus; keep statuses with >= 3 orders (RUN ON SalesDB)
SELECT OrderStatus,
       COUNT(OrderID) AS OrderCount,
       SUM(Sales) AS TotalSales
FROM Orders
GROUP BY OrderStatus
HAVING COUNT(OrderID) >= 3;

-- --- PRACTICE COPY OPERATIONS BELOW (RUN ONLY ON SalesDB_Practice) ---

-- 3.8 Insert three temporary test orders (OrderID = 301, 302, 303)
INSERT INTO Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime) VALUES
(301, 101, 1, 11, '2026-11-01', '2026-11-05', 'Shipped', 'Old St 1', 'Old St 1', 1, 55.00, '2026-11-01 10:00:00'),
(302, 102, 2, 11, '2026-11-02', NULL, 'Pending', 'Old St 2', 'Old St 2', 1, 230.00, '2026-11-02 10:00:00'),
(303, 104, 1, 11, '2026-11-03', NULL, 'Pending', 'Test St', 'Test St', 1, 12.00, '2026-11-03 10:00:00');

-- 3.9 Update ShipAddress of OrderID = 302, then delete OrderID = 303
UPDATE Orders
SET ShipAddress = '45 Main Street, Baku'
WHERE OrderID = 302;

DELETE FROM Orders
WHERE OrderID = 303;

-- 3.10 Delete any remaining temporary test orders with ShipAddress LIKE 'Old St%'
DELETE FROM Orders
WHERE ShipAddress LIKE 'Old St%';

SELECT * FROM Orders WHERE OrderID >= 300;

-- ============================================================================
-- SCENARIO 4: SALES PERFORMANCE & EMPLOYEE ANALYTICS (RUN ON CLEAN SalesDB)
-- ============================================================================

-- 4.1 List all employees sorted by Salary descending
SELECT EmployeeID, FirstName, LastName, Department, Salary
FROM Employees
ORDER BY Salary DESC;

-- 4.2 Find employees in Sales earning more than 2000
SELECT EmployeeID, FirstName, LastName, Department, Salary
FROM Employees
WHERE Department = 'Sales'
  AND Salary > 2000;

-- 4.3 Calculate minimum, maximum, average, and total salary per Department
SELECT Department,
       MIN(Salary) AS MinSalary,
       MAX(Salary) AS MaxSalary,
       ROUND(AVG(Salary), 2) AS AvgSalary,
       SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department;

-- 4.4 Show each employee alongside their manager's first and last name (self-join)
SELECT e.EmployeeID,
       e.FirstName AS EmployeeFirstName,
       e.LastName AS EmployeeLastName,
       m.FirstName AS ManagerFirstName,
       m.LastName AS ManagerLastName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

-- 4.5 Show all employees and any orders they handled (including zero orders)
SELECT e.EmployeeID, e.FirstName, e.LastName, o.OrderID, o.Sales
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.SalesPersonID;

-- 4.6 Show employees who handled zero orders
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Department
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.SalesPersonID
WHERE o.OrderID IS NULL;

-- 4.7 Calculate order count and total Sales per salesperson (including zero orders)
SELECT e.EmployeeID,
       e.FirstName,
       e.LastName,
       COUNT(o.OrderID) AS OrderCount,
       COALESCE(SUM(o.Sales), 0) AS TotalSales
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.SalesPersonID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC;

-- 4.8 Keep salespeople with at least 5 orders or total Sales >= 3000
SELECT e.EmployeeID,
       e.FirstName,
       e.LastName,
       COUNT(o.OrderID) AS OrderCount,
       COALESCE(SUM(o.Sales), 0) AS TotalSales
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.SalesPersonID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) >= 5
    OR COALESCE(SUM(o.Sales), 0) >= 3000;

-- 4.9 Build a complete order report joining Orders, Customers, Products, and Employees
SELECT o.OrderID,
       o.OrderDate,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       p.Product,
       p.Category,
       e.FirstName || ' ' || e.LastName AS SalesPersonName,
       o.Quantity,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID;

-- 4.10 Calculate total revenue and total quantity sold per Product Category
SELECT p.Category,
       SUM(o.Quantity) AS TotalQuantity,
       SUM(o.Sales) AS TotalRevenue
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalRevenue DESC;

-- 4.11 Calculate total revenue per Country and display countries with revenue > 1000
SELECT c.Country,
       SUM(o.Sales) AS TotalRevenue
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Country
HAVING SUM(o.Sales) > 1000
ORDER BY TotalRevenue DESC;

-- ============================================================================
-- SCENARIO 5: EXECUTIVE REPORTING & CROSS-ENTITY KPIs (RUN ON CLEAN SalesDB)
-- ============================================================================

-- 5.1 Show overall order KPIs: total orders, total quantity, total sales, avg, min, max
SELECT COUNT(OrderID) AS TotalOrders,
       SUM(Quantity) AS TotalQuantity,
       SUM(Sales) AS TotalSales,
       ROUND(AVG(Sales), 2) AS AverageSales,
       MIN(Sales) AS MinSales,
       MAX(Sales) AS MaxSales
FROM Orders;

-- 5.2 Group KPIs by OrderStatus
SELECT OrderStatus,
       COUNT(OrderID) AS OrderCount,
       SUM(Quantity) AS TotalQuantity,
       SUM(Sales) AS TotalSales,
       ROUND(AVG(Sales), 2) AS AverageSales
FROM Orders
GROUP BY OrderStatus;

-- 5.3 Group KPIs by Country and OrderStatus
SELECT c.Country,
       o.OrderStatus,
       COUNT(o.OrderID) AS OrderCount,
       SUM(o.Sales) AS TotalSales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Country, o.OrderStatus
ORDER BY c.Country ASC, TotalSales DESC;

-- 5.4 Group KPIs by Product Category and OrderStatus
SELECT p.Category,
       o.OrderStatus,
       COUNT(o.OrderID) AS OrderCount,
       SUM(o.Quantity) AS TotalQuantity,
       SUM(o.Sales) AS TotalSales
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Category, o.OrderStatus
ORDER BY p.Category ASC, TotalSales DESC;

-- 5.5 Identify top 5 highest-value orders with customer, product, and salesperson names
SELECT o.OrderID,
       o.OrderDate,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       p.Product,
       e.FirstName || ' ' || e.LastName AS SalesPersonName,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
ORDER BY o.Sales DESC
LIMIT 5;

-- 5.6 Rank customers by total spending (include zero-order customers)
SELECT c.CustomerID,
       c.FirstName,
       c.LastName,
       c.Country,
       COUNT(o.OrderID) AS OrderCount,
       COALESCE(SUM(o.Sales), 0) AS TotalSpending
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Country
ORDER BY TotalSpending DESC;

-- 5.7 Identify products that have never been ordered
SELECT p.ProductID, p.Product, p.Category, p.Price
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL;

-- 5.8 Compare total billed Sales against Price * Quantity to detect discrepancies
SELECT o.OrderID,
       p.Product,
       p.Price,
       o.Quantity,
       (p.Price * o.Quantity) AS ExpectedSales,
       o.Sales AS RecordedSales,
       (o.Sales - (p.Price * o.Quantity)) AS Difference
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Sales <> (p.Price * o.Quantity);

-- 5.9 Show daily order counts and daily revenue sorted chronologically
SELECT OrderDate,
       COUNT(OrderID) AS OrderCount,
       SUM(Sales) AS DailyRevenue
FROM Orders
GROUP BY OrderDate
ORDER BY OrderDate ASC;

-- 5.10 Find days with >= 2 orders or daily revenue >= 1000
SELECT OrderDate,
       COUNT(OrderID) AS OrderCount,
       SUM(Sales) AS DailyRevenue
FROM Orders
GROUP BY OrderDate
HAVING COUNT(OrderID) >= 2
    OR SUM(Sales) >= 1000
ORDER BY OrderDate ASC;

-- 5.11 Show Delivered orders only with Customer, Product, SalesPerson, and Sales
SELECT o.OrderID,
       o.OrderDate,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       p.Product,
       e.FirstName || ' ' || e.LastName AS SalesPersonName,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.OrderStatus = 'Delivered'
ORDER BY o.OrderDate ASC;

-- 5.12 Summarize Delivered revenue per customer and retain customers with Delivered revenue >= 1000
SELECT c.CustomerID,
       c.FirstName,
       c.LastName,
       c.Country,
       SUM(o.Sales) AS DeliveredRevenue
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderStatus = 'Delivered'
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Country
HAVING SUM(o.Sales) >= 1000
ORDER BY DeliveredRevenue DESC;

-- ============================================================================
-- SCENARIO 6: MULTI-TABLE AUDIT & EXCEPTION REPORTING (RUN ON CLEAN SalesDB)
-- ============================================================================

-- 6.1 List every order with customer name, product name, category, and salesperson name
SELECT o.OrderID,
       o.OrderDate,
       o.OrderStatus,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       p.Product,
       p.Category,
       e.FirstName || ' ' || e.LastName AS SalesPersonName,
       o.Quantity,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
ORDER BY o.OrderID ASC;

-- 6.2 Find orders where customer country is Germany or USA and order status is not Cancelled
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country,
       o.OrderStatus,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country IN ('Germany', 'USA')
  AND o.OrderStatus <> 'Cancelled';

-- 6.3 Find orders where ShipDate IS NULL and OrderStatus is not Cancelled
SELECT o.OrderID,
       o.OrderDate,
       o.ShipDate,
       o.OrderStatus,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       o.Sales
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.ShipDate IS NULL
  AND o.OrderStatus <> 'Cancelled';

-- 6.4 Find orders where ShipDate < OrderDate
SELECT o.OrderID,
       o.OrderDate,
       o.ShipDate,
       o.OrderStatus,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       e.FirstName || ' ' || e.LastName AS SalesPersonName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON o.SalesPersonID = e.EmployeeID
WHERE o.ShipDate < o.OrderDate;

-- 6.5 Find orders where ShipAddress <> BillAddress or either address is NULL
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       o.ShipAddress,
       o.BillAddress
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.ShipAddress <> o.BillAddress
   OR (o.ShipAddress IS NULL AND o.BillAddress IS NOT NULL)
   OR (o.ShipAddress IS NOT NULL AND o.BillAddress IS NULL)
   OR (o.ShipAddress IS NULL AND o.BillAddress IS NULL);

-- 6.6 Find customers who have never placed an order
SELECT c.CustomerID, c.FirstName, c.LastName, c.Country, c.Score
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- 6.7 Find products that have never been ordered
SELECT p.ProductID, p.Product, p.Category, p.Price
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL;

-- 6.8 Find employees who have never handled an order
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Department, e.Salary
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.SalesPersonID
WHERE o.OrderID IS NULL;

-- 6.9 Summarize order count and total Sales by Product Category and Customer Country
SELECT p.Category,
       c.Country,
       COUNT(o.OrderID) AS OrderCount,
       SUM(o.Sales) AS TotalSales
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY p.Category, c.Country
ORDER BY p.Category ASC, TotalSales DESC;

-- 6.10 Keep category-country combinations with at least 2 orders or total Sales >= 1500
SELECT p.Category,
       c.Country,
       COUNT(o.OrderID) AS OrderCount,
       SUM(o.Sales) AS TotalSales
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY p.Category, c.Country
HAVING COUNT(o.OrderID) >= 2
    OR SUM(o.Sales) >= 1500
ORDER BY p.Category ASC, TotalSales DESC;