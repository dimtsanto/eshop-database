USE `e_shop1`;


-- 1. Number of customers by gender
SELECT s.Type AS sex_type, COUNT(c.id_customer) AS num_customers
FROM customer c
JOIN sex s ON c.id_sex = s.id_sex
GROUP BY c.id_sex;

-- 2. All purchases of a customer (id = 1) with product and cost details
SELECT c.lname,
       c.fname,
       c.phone,
       oi.quantity,
       p.name AS product_name,
       p.price,
       (p.price * oi.quantity) AS cost
FROM customer c
JOIN `order` o ON c.id_customer = o.id_customer
JOIN itemsordered oi ON o.id_order = oi.id_order
JOIN product p ON p.id_product = oi.id_product
WHERE c.id_customer = 1;

-- 3. Top 10 products by total quantity sold
SELECT p.name AS product_name, 
       SUM(oi.quantity) AS total_quantity
FROM product p
JOIN itemsordered oi ON p.id_product = oi.id_product
GROUP BY p.name
ORDER BY total_quantity DESC
LIMIT 10;

-- 4. Cities with the highest total purchase spending
SELECT a.city AS city_name, 
       COALESCE(SUM(oi.quantity * p.price), 0) AS total_spent
FROM address a
JOIN customer c ON a.id_customer = c.id_customer
JOIN `order` o ON c.id_customer = o.id_customer
JOIN itemsordered oi ON o.id_order = oi.id_order
JOIN product p ON oi.id_product = p.id_product
GROUP BY a.city
ORDER BY total_spent DESC;

-- 5. Customers who have spent more than €500
SELECT c.fname, c.lname, SUM(p.amount) AS TotalSpent
FROM customer c
JOIN `order` o ON c.id_customer = o.id_customer
JOIN payment p ON o.id_order = p.id_order
GROUP BY c.id_customer
HAVING TotalSpent > 500;

-- 6. List of customers with the total amount they have paid
SELECT c.id_customer, c.fname, c.lname, COALESCE(SUM(p.amount),0) AS total_paid
FROM customer c
LEFT JOIN `order` o ON c.id_customer = o.id_customer
LEFT JOIN payment p ON o.id_order = p.id_order
GROUP BY c.id_customer;

-- 7. Products that have never been sold
SELECT p.id_product, p.name
FROM product p
LEFT JOIN itemsordered oi ON p.id_product = oi.id_product
WHERE oi.id_itemsordered IS NULL;

-- 8. Shipping information for each order
SELECT o.id_order, o.status, sh.shipment_date AS shipment_date, sh.country AS shipment_country, sh.shipment_number AS shipment_number, sh.continent AS shipment_region
FROM `order` o
LEFT JOIN shipment sh ON o.id_order = sh.id_order;

-- 9. Total sales per month (e.g. for 2025)
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month, 
       SUM(oi.quantity * p.price) AS total_sales
FROM `order` o
JOIN itemsordered oi ON o.id_order = oi.id_order
JOIN product p ON oi.id_product = p.id_product
WHERE YEAR(o.order_date) = 2025
GROUP BY month
ORDER BY MONTH;

-- 10. Customers who have not placed an order in the last year
SELECT c.id_customer, c.fname, c.lname
FROM customer c
LEFT JOIN `order` o ON c.id_customer = o.id_customer
    AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
WHERE o.id_order IS NULL;

-- 11. Average number of products per order
SELECT AVG(items_count) AS avg_items_per_order FROM (
    SELECT COUNT(*) AS items_count
    FROM itemsordered
    GROUP BY id_order
) AS sub;

-- 12. List of products with the average price per unit (if ordered)
SELECT p.id_product, p.name, p.price AS avg_price
FROM product p
JOIN itemsordered oi ON p.id_product = oi.id_product
GROUP BY p.id_product;

-- 13. Customers who have paid with a specific payment method (e.g., "Credit Card")
SELECT DISTINCT c.id_customer, c.fname, c.lname
FROM customer c
JOIN `order` o ON c.id_customer = o.id_customer
JOIN payment p ON o.id_order = p.id_order
WHERE p.method = 'Credit Card';

-- 14. Products that have been ordered at least 5 times
SELECT p.id_product, p.name, COUNT(DISTINCT oi.id_order) AS order_count
FROM product p
JOIN itemsordered oi ON p.id_product = oi.id_product
GROUP BY p.id_product
HAVING order_count >= 5;

-- 15. Customers with the most different products purchased
SELECT c.id_customer, c.fname, c.lname, COUNT(DISTINCT oi.id_product) AS distinct_products
FROM customer c
JOIN `order` o ON c.id_customer = o.id_customer
JOIN itemsordered oi ON o.id_order = oi.id_order
GROUP BY c.id_customer
ORDER BY distinct_products DESC
LIMIT 10;
