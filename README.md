🛒 Task 3: SQL for Data Analysis — Ecommerce SQL Database
📌 Objective
Use SQL queries to extract and analyze data from a relational e-commerce database, demonstrating real-world data analysis skills using structured query language.

🛠️ Tools Used

MySQL Workbench (MySQL Community Server)
Compatible with PostgreSQL and SQLite (minor syntax adjustments needed)

🔍 SQL Concepts Covered
A. SELECT, WHERE, ORDER BY, GROUP BY

List all delivered orders sorted by date
Products priced above ₹2000
Total orders per customer
Revenue per product category

B. JOINs

INNER JOIN — Orders with customer names
3-table JOIN — Full order details at product level
LEFT JOIN — All customers including those with no orders
LEFT JOIN — All products including those never ordered
RIGHT JOIN — All customers regardless of order activity

C. Subqueries

Products priced above the average
Customers who have never placed an order
Top 3 customers by total spend (correlated subquery)
Orders with above-average order value (derived table subquery)

D. Aggregate Functions

SUM — Total revenue, category-wise and overall
AVG — Average order value per customer
COUNT — Total orders, total customers
MIN / MAX — Cheapest and costliest item prices
Best-selling products by units sold

📊 Sample Insights from Queries

💰 Electronics is the top revenue-generating category
🏆 Aarav Sharma placed the most orders (3 orders)
📦 USB-C Cable was the highest-selling product by units
📅 February 2024 had the highest monthly revenue
🚫 Some customers signed up but never placed an order (found via subquery)

