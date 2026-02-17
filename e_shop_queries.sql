-- 1. Πλήθος πελατών ανά φύλο
SELECT s.Type AS sex_type, COUNT(c.id_customer) AS num_customers
FROM customer c
JOIN sex s ON c.id_sex = s.id_sex
GROUP BY c.id_sex;

-- 2. Όλες οι αγορές ενός πελάτη (id = 1) με λεπτομέρειες προϊόντων και κόστους
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

-- 3. Top 10 προϊόντα με τις περισσότερες πωλήσεις σε ποσότητα
SELECT p.name AS product_name, 
       SUM(oi.quantity) AS total_quantity
FROM product p
JOIN itemsordered oi ON p.id_product = oi.id_product
GROUP BY p.name
ORDER BY total_quantity DESC
LIMIT 10;

-- 4. Πόλεις με τα υψηλότερα συνολικά έξοδα αγορών
SELECT a.Πολη AS city_name, 
       COALESCE(SUM(oi.quantity * p.price), 0) AS total_spent
FROM address a
JOIN customer c ON a.id_customer = c.id_customer
JOIN `order` o ON c.id_customer = o.id_customer
JOIN itemsordered oi ON o.id_order = oi.id_order
JOIN product p ON oi.id_product = p.id_product
GROUP BY a.Πολη
ORDER BY total_spent DESC;

-- 5. Πελάτες που έχουν ξοδέψει πάνω από 500€
SELECT c.fname, c.lname, SUM(p.amount) AS TotalSpent
FROM customer c
JOIN `order` o ON c.id_customer = o.id_customer
JOIN payment p ON o.id_order = p.id_order
GROUP BY c.id_customer
HAVING TotalSpent > 500;

-- 6. Λίστα πελατών με το συνολικό ποσό που έχουν πληρώσει
SELECT c.id_customer, c.fname, c.lname, COALESCE(SUM(p.amount),0) AS total_paid
FROM customer c
LEFT JOIN `order` o ON c.id_customer = o.id_customer
LEFT JOIN payment p ON o.id_order = p.id_order
GROUP BY c.id_customer;

-- 7. Προϊόντα που δεν έχουν πουληθεί ποτέ
SELECT p.id_product, p.name
FROM product p
LEFT JOIN itemsordered oi ON p.id_product = oi.id_product
WHERE oi.id_itemsordered IS NULL;

-- 8. Πληροφορίες αποστολής για κάθε παραγγελία
SELECT o.id_order, o.status, sh.Ημερομηνια_αποστολης AS shipment_date, sh.Χωρα AS shipment_country, sh.Αριθμος_αποστολης AS shipment_number, sh.Ηπειρος AS shipment_region
FROM `order` o
LEFT JOIN shipment sh ON o.id_order = sh.id_order;

-- 9. Συνολικές πωλήσεις ανά μήνα (για το 2024 πχ)
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month, 
       SUM(oi.quantity * p.price) AS total_sales
FROM `order` o
JOIN itemsordered oi ON o.id_order = oi.id_order
JOIN product p ON oi.id_product = p.id_product
WHERE YEAR(o.order_date) = 2024
GROUP BY month
ORDER BY MONTH;

-- 10. Πελάτες που δεν έχουν κάνει παραγγελία τον τελευταίο χρόνο
SELECT c.id_customer, c.fname, c.lname
FROM customer c
LEFT JOIN `order` o ON c.id_customer = o.id_customer
    AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
WHERE o.id_order IS NULL;

-- 11. Μέσος όρος ποσότητας προϊόντων ανά παραγγελία
SELECT AVG(items_count) AS avg_items_per_order FROM (
    SELECT COUNT(*) AS items_count
    FROM itemsordered
    GROUP BY id_order
) AS sub;

-- 12. Λίστα προϊόντων με το μέσο κόστος ανά τεμάχιο (αν έχει γίνει παραγγελία)
SELECT p.id_product, p.name, p.price AS avg_price
FROM product p
JOIN itemsordered oi ON p.id_product = oi.id_product
GROUP BY p.id_product;

-- 13. Πελάτες που έχουν πληρώσει με συγκεκριμένο τρόπο πληρωμής (πχ "Credit Card")
SELECT DISTINCT c.id_customer, c.fname, c.lname
FROM customer c
JOIN `order` o ON c.id_customer = o.id_customer
JOIN payment p ON o.id_order = p.id_order
WHERE p.method = 'Credit Card';

-- 14. Προϊόντα που έχουν παραγγελθεί τουλάχιστον 5 φορές
SELECT p.id_product, p.name, COUNT(DISTINCT oi.id_order) AS order_count
FROM product p
JOIN itemsordered oi ON p.id_product = oi.id_product
GROUP BY p.id_product
HAVING order_count >= 5;

-- 15. Πελάτες με τα περισσότερα διαφορετικά προϊόντα που έχουν αγοράσει
SELECT c.id_customer, c.fname, c.lname, COUNT(DISTINCT oi.id_product) AS distinct_products
FROM customer c
JOIN `order` o ON c.id_customer = o.id_customer
JOIN itemsordered oi ON o.id_order = oi.id_order
GROUP BY c.id_customer
ORDER BY distinct_products DESC
LIMIT 10;
