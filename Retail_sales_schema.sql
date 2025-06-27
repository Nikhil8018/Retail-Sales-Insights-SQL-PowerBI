CREATE DATABASE retail_sales;
USE retail_sales;
CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100),
    Segment VARCHAR(50),
    Region VARCHAR(50)
);

CREATE TABLE Products (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    SubCategory VARCHAR(50)
);


CREATE TABLE Orders (
    OrderID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10),
    OrderDate DATE,
    Region VARCHAR(50),
    Sales DECIMAL(10,2),
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Sales (
    OrderID VARCHAR(10),
    ProductID VARCHAR(10),
    UnitsSold INT,
    UnitPrice DECIMAL(10,2),
    Profit DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Regions (
    Region VARCHAR(50) PRIMARY KEY,
    ManagerName VARCHAR(100),
    Target DECIMAL(10,2)
);

select * from orders;

SELECT 
    o.OrderID,
    o.OrderDate,
    o.Region,
    c.CustomerName,
    c.Segment,
    p.ProductName,
    p.Category,
    p.SubCategory,
    s.UnitsSold,
    s.UnitPrice,
    (s.UnitsSold * s.UnitPrice) AS TotalSales,
    s.Profit
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Sales s ON o.OrderID = s.OrderID
JOIN Products p ON s.ProductID = p.ProductID;

SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(s.UnitsSold * s.UnitPrice) AS TotalSales,
    SUM(s.Profit) AS TotalProfit
FROM Orders o
JOIN Sales s ON o.OrderID = s.OrderID
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
ORDER BY Month;

SELECT 
    o.Region,
    SUM(s.UnitsSold * s.UnitPrice) AS TotalSales,
    SUM(s.Profit) AS TotalProfit
FROM Orders o
JOIN Sales s ON o.OrderID = s.OrderID
GROUP BY o.Region;


SELECT 
    p.ProductName,
    SUM(s.UnitsSold * s.UnitPrice) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC
LIMIT 5;

SELECT 
    c.Segment,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(s.UnitsSold * s.UnitPrice) AS Revenue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Sales s ON o.OrderID = s.OrderID
GROUP BY c.Segment;













