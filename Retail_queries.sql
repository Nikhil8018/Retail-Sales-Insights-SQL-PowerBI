-- 1. Total Sales & Profit by Region


SELECT 
    o.Region,
    SUM(s.UnitsSold * s.UnitPrice) AS TotalSales,
    SUM(s.Profit) AS TotalProfit
FROM Orders o
JOIN Sales s ON o.OrderID = s.OrderID
GROUP BY o.Region;

-- 2. Monthly Sales Trend
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(s.UnitsSold * s.UnitPrice) AS TotalSales,
    SUM(s.Profit) AS TotalProfit
FROM Orders o
JOIN Sales s ON o.OrderID = s.OrderID
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
ORDER BY Month;

-- 3. Top 5 Products by Revenue
SELECT 
    p.ProductName,
    SUM(s.UnitsSold * s.UnitPrice) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC
LIMIT 5;

-- 4. Sales by Customer Segment
SELECT 
    c.Segment,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(s.UnitsSold * s.UnitPrice) AS Revenue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Sales s ON o.OrderID = s.OrderID
GROUP BY c.Segment;

-- 5. Sales and Profit with Product Details
SELECT 
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    c.Segment,
    p.ProductName,
    s.UnitsSold,
    s.UnitPrice,
    s.Profit
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Sales s ON o.OrderID = s.OrderID
JOIN Products p ON s.ProductID = p.ProductID;
