USE `e_shop1`;

DELETE FROM `address`;
INSERT INTO `address` (`id_address`, `id_customer`, `street`, `building`, `city`, `postal_code`, `country`) VALUES
	(1, 1, 'Leoforos Kifisias', 10, 'Athens', '11523', 'Greece'),
	(2, 2, 'Ermou', 5, 'Athens', '10563', 'Greece'),
	(3, 3, 'Tsimiski', 3, 'Thessaloniki', '54623', 'Greece'),
	(4, 4, 'Egnatia', 7, 'Thessaloniki', '54630', 'Greece'),
	(5, 5, 'Patision', 15, 'Athens', '11252', 'Greece'),
	(6, 6, 'Vouliagmenis', 21, 'Athens', '11743', 'Greece'),
	(7, 7, 'Panepistimiou', 12, 'Athens', '10679', 'Greece'),
	(8, 8, 'Ionos Dragoumi', 4, 'Thessaloniki', '54625', 'Greece'),
	(9, 9, 'Kifisou', 18, 'Athens', '12242', 'Greece'),
	(10, 10, 'Perikleous', 6, 'Athens', '10563', 'Greece');

DELETE FROM `category`;
INSERT INTO `category` (`id_category`, `category_name`) VALUES
	(1, 'Electronics'),
	(2, 'Clothing'),
	(3, 'Books'),
	(4, 'Home Appliances'),
	(5, 'Toys'),
	(6, 'Beauty'),
	(7, 'Sports'),
	(8, 'Jewelry'),
	(9, 'Automotive'),
	(10, 'Garden');

DELETE FROM `customer`;
INSERT INTO `customer` (`id_customer`, `lname`, `fname`, `birthday`, `username`, `password`, `email`, `phone`, `id_address`, `id_sex`) VALUES
	(1, 'Smith', 'John', '1990-01-01', 'jsmith', 'pass123', 'john@example.com', '2100000001', NULL, 1),
	(2, 'Doe', 'Jane', '1992-02-02', 'jdoe', 'pass234', 'jane@example.com', '2100000002', NULL, 2),
	(3, 'Brown', 'Charlie', '1985-03-03', 'cbrown', 'pass345', 'charlie@example.com', '2100000003', NULL, 1),
	(4, 'Taylor', 'Emma', '1995-04-04', 'etaylor', 'pass456', 'emma@example.com', '2100000004', NULL, 2),
	(5, 'Wilson', 'Liam', '1991-05-05', 'lwilson', 'pass567', 'liam@example.com', '2100000005', NULL, 1),
	(6, 'Moore', 'Olivia', '1993-06-06', 'omoore', 'pass678', 'olivia@example.com', '2100000006', NULL, 2),
	(7, 'Anderson', 'Noah', '1988-07-07', 'nanderson', 'pass789', 'noah@example.com', '2100000007', NULL, 1),
	(8, 'Thomas', 'Ava', '1996-08-08', 'athomas', 'pass890', 'ava@example.com', '2100000008', NULL, 2),
	(9, 'Jackson', 'Sophia', '1997-09-09', 'sjackson', 'pass901', 'sophia@example.com', '2100000009', NULL, 2),
	(10, 'White', 'James', '1989-10-10', 'jwhite', 'pass012', 'james@example.com', '2100000010', NULL, 1);

DELETE FROM `itemsordered`;
INSERT INTO `itemsordered` (`id_itemsordered`, `id_order`, `id_product`, `quantity`, `price`) VALUES
	(1, 1, 1, 1, 699.99),
	(2, 2, 2, 1, 999.99),
	(3, 3, 3, 3, 59.97),
	(4, 4, 4, 1, 49.99),
	(5, 5, 5, 2, 29.98),
	(6, 6, 6, 2, 59.98),
	(7, 7, 7, 1, 59.99),
	(8, 8, 8, 1, 39.99),
	(9, 9, 9, 2, 49.98),
	(10, 10, 10, 1, 19.99);

DELETE FROM `order`;
INSERT INTO `order` (`id_order`, `id_customer`, `order_date`, `status`) VALUES
	(1, 1, '2025-05-01', 'Pending'),
	(2, 2, '2025-05-02', 'Shipped'),
	(3, 3, '2025-05-03', 'Delivered'),
	(4, 4, '2025-05-04', 'Cancelled'),
	(5, 5, '2025-05-05', 'Pending'),
	(6, 6, '2025-05-06', 'Delivered'),
	(7, 7, '2025-05-07', 'Shipped'),
	(8, 8, '2025-05-08', 'Pending'),
	(9, 9, '2025-05-09', 'Delivered'),
	(10, 10, '2025-05-10', 'Pending');

DELETE FROM `payment`;
INSERT INTO `payment` (`id_payment`, `id_order`, `payment_date`, `amount`, `method`) VALUES
	(1, 1, '2025-05-01', 699.99, 'Credit Card'),
	(2, 2, '2025-05-02', 999.99, 'Debit Card'),
	(3, 3, '2025-05-03', 59.97, 'PayPal'),
	(4, 4, '2025-05-04', 49.99, 'Bank Transfer'),
	(5, 5, '2025-05-05', 29.98, 'Cash'),
	(6, 6, '2025-05-06', 59.98, 'Credit Card'),
	(7, 7, '2025-05-07', 59.99, 'PayPal'),
	(8, 8, '2025-05-08', 39.99, 'Debit Card'),
	(9, 9, '2025-05-09', 49.98, 'Cash'),
	(10, 10, '2025-05-10', 19.99, 'Credit Card');

DELETE FROM `product`;
INSERT INTO `product` (`id_product`, `name`, `description`, `price`, `stock`, `id_category`) VALUES
	(1, 'Smartphone', 'Latest Android smartphone', 699.99, 100, 1),
	(2, 'Laptop', '15-inch high performance laptop', 999.99, 50, 1),
	(3, 'T-shirt', 'Cotton T-shirt', 19.99, 200, 2),
	(4, 'Blender', 'Kitchen blender with 3 speeds', 49.99, 30, 4),
	(5, 'Novel', 'Bestseller fiction novel', 14.99, 80, 3),
	(6, 'Basketball', 'Standard size basketball', 29.99, 40, 7),
	(7, 'Necklace', 'Gold plated necklace', 59.99, 25, 8),
	(8, 'Perfume', 'Floral scent perfume', 39.99, 70, 6),
	(9, 'Toy Car', 'Battery operated toy car', 24.99, 60, 5),
	(10, 'Garden Hose', '10-meter garden hose', 19.99, 35, 10);

DELETE FROM `reviews`;
INSERT INTO `reviews` (`id_review`, `id_customer`, `id_product`, `review_score`) VALUES
	(1, 1, 1, 9),
	(2, 2, 2, 8),
	(3, 3, 3, 10),
	(4, 4, 4, 7),
	(5, 5, 5, 6),
	(6, 6, 6, 9),
	(7, 7, 7, 10),
	(8, 8, 8, 8),
	(9, 9, 9, 7),
	(10, 10, 10, 10);

DELETE FROM `sex`;
INSERT INTO `sex` (`id_sex`, `Type`) VALUES
	(1, 'Male'),
	(2, 'Female'),
	(3, 'Other');

DELETE FROM `shipment`;
INSERT INTO `shipment` (`id_shipment`, `id_order`, `shipment_date`, `country`, `shipment_number`, `continent`) VALUES
	(1, 1, '2025-05-02', 1, 123001, 1),
	(2, 2, '2025-05-03', 1, 123002, 1),
	(3, 3, '2025-05-04', 1, 123003, 1),
	(4, 4, '2025-05-05', 1, 123004, 1),
	(5, 5, '2025-05-06', 1, 123005, 1),
	(6, 6, '2025-05-07', 1, 123006, 1),
	(7, 7, '2025-05-08', 1, 123007, 1),
	(8, 8, '2025-05-09', 1, 123008, 1),
	(9, 9, '2025-05-10', 1, 123009, 1),
	(10, 10, '2025-05-11', 1, 123010, 1);
