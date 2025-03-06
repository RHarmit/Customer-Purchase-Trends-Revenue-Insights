Step 1: Create the Database & Tables

CREATE DATABASE IF NOT EXISTS Zack_Data;
USE Zack_Data;

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    location VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    sale_date DATE,
    product VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    total_revenue DECIMAL(10,2) GENERATED ALWAYS AS (quantity * price) VIRTUAL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


Step 2: Insert Sample Data

INSERT INTO Customers (customer_id, customer_name, location) 
VALUES 
(1, 'John Doe', 'Chicago'),
(2, 'Alice Smith', 'New York'),
(3, 'Bob Johnson', 'Los Angeles');

INSERT INTO Sales (sale_id, customer_id, sale_date, product, quantity, price)
VALUES 
(1, 1, '2024-03-01', 'Roofing Shingles', 10, 25.50),
(2, 2, '2024-03-01', 'Vinyl Siding', 5, 40.00),
(3, 1, '2024-03-02', 'Windows', 3, 150.00),
(4, 3, '2024-03-02', 'Lumber', 7, 12.75),
(5, 2, '2024-03-03', 'Doors', 2, 120.00);


Identify Top Customers by Spending

SELECT 
    c.customer_name, 
    c.location, 
    COUNT(s.sale_id) AS total_purchases,
    SUM(s.total_revenue) AS total_spent
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name, c.location
ORDER BY total_spent DESC;

Monthly Revenue Trends

SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS month, 
    SUM(total_revenue) AS total_revenue
FROM Sales
GROUP BY month
ORDER BY month DESC;