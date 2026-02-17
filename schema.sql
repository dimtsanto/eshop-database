CREATE DATABASE IF NOT EXISTS `e_shop`;
USE `e_shop`;

CREATE TABLE IF NOT EXISTS `address` (
`id_address` int NOT NULL AUTO_INCREMENT,
`id_customer` int NOT NULL,
`Δρομος` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`Οδος` tinyint DEFAULT NOT NULL,
`Πολη` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`ΤΚ` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
`Χωρα` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
PRIMARY KEY (`id_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `category` (
`id_category` int NOT NULL AUTO_INCREMENT,
`Category_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `customer` (
`id_customer` int NOT NULL AUTO_INCREMENT,
`lname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NOT NULL,
`fname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NOT NULL,
`birthday` date DEFAULT NULL,
`username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NOT NULL,
`password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NOT NULL,
`email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NOT NULL,
`phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NOT NULL,
`id_adress` int DEFAULT NOT NULL,
`id_sex` tinyint DEFAULT NULL,
PRIMARY KEY (`id_customer`),
KEY `id_adress` (`id_adress`),
KEY `id_sex` (`id_sex`)
) ENGINE=InnoDB AUTO_INCREMENT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `order` (
`id_order` int NOT NULL AUTO_INCREMENT,
`id_customer` int DEFAULT NULL,
`order_date` date DEFAULT NOT NULL,
`status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NOT NULL,
PRIMARY KEY (`id_order`),
KEY `id_customer` (`id_customer`)
) ENGINE=InnoDB AUTO_INCREMENT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `itemsordered` (
`id_itemsordered` int NOT NULL AUTO_INCREMENT,
`id_order` int DEFAULT NULL,
`id_product` int DEFAULT NULL,
`quantity` int DEFAULT NULL,
`price` decimal(10,2) DEFAULT NULL,
PRIMARY KEY (`id_itemsordered`),
KEY `id_order` (`id_order`),
KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `payment` (
`id_payment` int NOT NULL AUTO_INCREMENT,
`id_order` int DEFAULT NULL,
`payment_date` date DEFAULT NULL,
`amount` decimal(10,2) DEFAULT NULL,
`method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`id_payment`),
KEY `id_order` (`id_order`)
) ENGINE=InnoDB AUTO_INCREMENT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `product` (
`id_product` int NOT NULL AUTO_INCREMENT,
`name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
`price` decimal(10,2) DEFAULT NULL,
`stock` int DEFAULT NULL,
`id_category` int DEFAULT NULL,
PRIMARY KEY (`id_product`),
KEY `id_category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `reviews` (
`id_review` int NOT NULL AUTO_INCREMENT,
`id_customer` int DEFAULT NULL,
`id_product` int DEFAULT NULL,
`Review_Score` tinyint DEFAULT NULL,
PRIMARY KEY (`id_review`),
KEY `id_customer` (`id_customer`),
KEY `id_product` (`id_product`),
CONSTRAINT `chk_review_score` CHECK ((`Review_Score` between 1 and 10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `sex` (
`id_sex` int NOT NULL AUTO_INCREMENT,
`Type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`id_sex`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `shipment` (
`id_shipment` int NOT NULL AUTO_INCREMENT,
`id_order` int DEFAULT NOT NULL,
`Ημερομηνια_αποστολης` date DEFAULT NULL,
`Χωρα` tinyint DEFAULT NULL,
`Αριθμος_αποστολης` int DEFAULT NOT NULL,
`Ηπειρος` int DEFAULT NULL,
PRIMARY KEY (`id_shipment`),
KEY `id_order` (`id_order`)

) ENGINE=InnoDB AUTO_INCREMENT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
