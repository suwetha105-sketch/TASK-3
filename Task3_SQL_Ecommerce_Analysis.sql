
CREATE DATABASE ecommerce_sql_database;
USE ecommerce_sql_database;

-- ---------- CUSTOMERS ----------
CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city          VARCHAR(50),
    country       VARCHAR(50),
    signup_date   DATE
);

INSERT INTO customers (customer_id, customer_name, city, country, signup_date) VALUES
(1, 'Aarav Sharma',   'Coimbatore', 'India', '2023-01-15'),
(2, 'Priya Nair',     'Chennai',    'India', '2023-02-20'),
(3, 'Rahul Verma',    'Bengaluru',  'India', '2023-03-05'),
(4, 'Sneha Iyer',     'Mumbai',     'India', '2023-04-10'),
(5, 'John Smith',     'New York',  'USA',    '2023-01-25'),
(6, 'Emma Watson',    'London',    'UK',     '2023-05-18'),
(7, 'Liu Wei',        'Shanghai',  'China',  '2023-06-01'),
(8, 'Karan Mehta',    'Delhi',     'India', '2023-06-15'),
(9, 'Sofia Rossi',    'Milan',     'Italy',  '2023-07-02'),
(10,'Ahmed Khan',     'Dubai',     'UAE',    '2023-07-20');

SELECT * FROM customers;

-- ---------- PRODUCTS ----------
CREATE TABLE products (
    product_id    INT PRIMARY KEY,
    product_name  VARCHAR(100),
    category      VARCHAR(50),
    price         DECIMAL(10,2),
    stock_qty     INT
);

INSERT INTO products (product_id, product_name, category, price, stock_qty) VALUES
(101, 'Wireless Mouse',      'Electronics', 599.00, 150),
(102, 'Mechanical Keyboard', 'Electronics', 2499.00, 80),
(103, 'USB-C Cable',         'Electronics', 199.00, 300),
(104, 'Office Chair',        'Furniture',   4999.00, 40),
(105, 'Study Table',         'Furniture',   6999.00, 25),
(106, 'Running Shoes',       'Footwear',    2999.00, 100),
(107, 'Formal Shoes',        'Footwear',    3499.00, 60),
(108, 'Backpack',            'Accessories', 1499.00, 120),
(109, 'Water Bottle',        'Accessories', 299.00, 200),
(110, 'Bluetooth Speaker',   'Electronics', 1999.00, 70);

-- ---------- ORDERS ----------
CREATE TABLE orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    order_date    DATE,
    status        VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(1001, 1, '2024-01-05', 'Delivered'),
(1002, 2, '2024-01-10', 'Delivered'),
(1003, 3, '2024-01-15', 'Cancelled'),
(1004, 1, '2024-02-02', 'Delivered'),
(1005, 4, '2024-02-08', 'Delivered'),
(1006, 5, '2024-02-14', 'Pending'),
(1007, 6, '2024-03-01', 'Delivered'),
(1008, 2, '2024-03-10', 'Delivered'),
(1009, 7, '2024-03-15', 'Delivered'),
(1010, 8, '2024-04-01', 'Delivered'),
(1011, 9, '2024-04-05', 'Cancelled'),
(1012, 3, '2024-04-20', 'Delivered'),
(1013, 10,'2024-05-02', 'Delivered'),
(1014, 1, '2024-05-15', 'Pending'),
(1015, 4, '2024-05-28', 'Delivered');

-- ---------- ORDER_ITEMS ----------
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id      INT,
    product_id    INT,
    quantity      INT,
    unit_price    DECIMAL(10,2),
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 101, 2, 599.00),
(2, 1001, 103, 3, 199.00),
(3, 1002, 104, 1, 4999.00),
(4, 1003, 106, 1, 2999.00),
(5, 1004, 102, 1, 2499.00),
(6, 1004, 109, 2, 299.00),
(7, 1005, 105, 1, 6999.00),
(8, 1006, 108, 2, 1499.00),
(9, 1007, 110, 1, 1999.00),
(10,1008, 101, 1, 599.00),
(11,1008, 107, 1, 3499.00),
(12,1009, 103, 5, 199.00),
(13,1010, 106, 2, 2999.00),
(14,1011, 104, 1, 4999.00),
(15,1012, 109, 3, 299.00),
(16,1013, 102, 1, 2499.00),
(17,1014, 108, 1, 1499.00),
(18,1015, 110, 2, 1999.00),
(19,1015, 101, 1, 599.00);


/* ============================================================
   PART A: SELECT, WHERE, ORDER BY, GROUP BY
   ============================================================ */

SELECT order_id, customer_id, order_date, status
FROM orders
WHERE status = 'Delivered'
ORDER BY order_date;

-- A2. Products priced above ₹2000, sorted by price descending
SELECT product_name, category, price
FROM products
WHERE price > 2000
ORDER BY price DESC;

-- A3. Total number of orders placed by each customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- A4. Total revenue generated per product category
SELECT p.category, SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- A5. Customers who joined after March 2023, sorted by signup date
SELECT customer_name, city, country, signup_date
FROM customers
WHERE signup_date > '2023-03-31'
ORDER BY signup_date;


/* ============================================================
   PART B: JOINS (INNER, LEFT, RIGHT)
   ============================================================ */

-- B1. INNER JOIN: Orders with customer names
SELECT o.order_id, c.customer_name, o.order_date, o.status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date;

-- B2. INNER JOIN across 3 tables: full order details (product level)
SELECT o.order_id, c.customer_name, p.product_name,
       oi.quantity, oi.unit_price,
       (oi.quantity * oi.unit_price) AS line_total
FROM orders o
JOIN customers c   ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p     ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- B3. LEFT JOIN: All customers, including those with NO orders
SELECT c.customer_id, c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- B4. LEFT JOIN: All products, including those NEVER ordered
SELECT p.product_id, p.product_name, oi.order_id
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

-- B5. RIGHT JOIN (MySQL/PostgreSQL syntax; SQLite has no RIGHT JOIN
--     -- swap table order and use LEFT JOIN instead if using SQLite)
SELECT o.order_id, c.customer_name
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id
ORDER BY c.customer_id;


/* ============================================================
   PART C: SUBQUERIES
   ============================================================ */

-- C1. Products priced above the average product price
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- C2. Customers who have never placed an order
SELECT customer_name
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- C3. Customer(s) with the highest total spend (correlated subquery)
SELECT c.customer_name,
       (SELECT SUM(oi.quantity * oi.unit_price)
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        WHERE o.customer_id = c.customer_id) AS total_spend
FROM customers c
ORDER BY total_spend DESC
LIMIT 3;

-- C4. Orders whose total value exceeds the overall average order value
SELECT order_id, order_total
FROM (
    SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
) t
WHERE order_total > (
    SELECT AVG(sub.order_total) FROM (
        SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS order_total
        FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY o.order_id
    ) sub
);


/* ============================================================
   PART D: AGGREGATE FUNCTIONS (SUM, AVG, COUNT, MIN, MAX)
   ============================================================ */

-- D1. Overall business metrics
SELECT
    COUNT(DISTINCT o.order_id)     AS total_orders,
    COUNT(DISTINCT o.customer_id)  AS total_customers,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    AVG(oi.quantity * oi.unit_price) AS avg_line_value,
    MIN(oi.unit_price)             AS cheapest_item_price,
    MAX(oi.unit_price)             AS costliest_item_price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;

-- D2. Average order value per customer
SELECT c.customer_name,
       ROUND(AVG(order_total.total), 2) AS avg_order_value
FROM customers c
JOIN (
    SELECT o.order_id, o.customer_id, SUM(oi.quantity*oi.unit_price) AS total
    FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, o.customer_id
) AS order_total ON c.customer_id = order_total.customer_id
GROUP BY c.customer_name
ORDER BY avg_order_value DESC;

-- D3. Best-selling product by quantity sold
SELECT p.product_name, SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 5;


/* ============================================================
   PART E: CREATE VIEWS FOR ANALYSIS
   ============================================================ */

-- E1. View: complete order-level revenue summary
CREATE VIEW vw_order_summary AS
SELECT o.order_id, c.customer_name, o.order_date, o.status,
       SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN customers c    ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.customer_name, o.order_date, o.status;

-- Usage:
-- SELECT * FROM vw_order_summary WHERE status = 'Delivered' ORDER BY order_total DESC;

-- E2. View: monthly revenue trend
CREATE VIEW vw_monthly_revenue AS
SELECT strftime('%Y-%m', o.order_date) AS order_month,   -- MySQL: DATE_FORMAT(o.order_date,'%Y-%m')
       SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY order_month
ORDER BY order_month;

-- E3. View: category-wise product performance
CREATE VIEW vw_category_performance AS
SELECT p.category,
       COUNT(DISTINCT oi.order_id) AS orders_count,
       SUM(oi.quantity)            AS units_sold,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category;

SELECT * FROM customers;

