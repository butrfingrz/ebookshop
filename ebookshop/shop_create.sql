--Andrea Fletcher
--Module 6
--Create database and tables for it

--If the Shop databse exists already, delete it
DROP DATABASE IF EXISTS `shop`;

--create the shop database
CREATE DATABASE `shop`;

--Create table: categories
--Key: category_id
CREATE TABLE `shop`.`categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(70) NOT NULL, 
  PRIMARY KEY (`category_id`),
  KEY `category_id_key` (`category_id`)
  );
 
--Create table: books  
--Key:book_id
--Constraints:
--Don't let a category be assigned to a book that 
--  does not exist in the category table
CREATE TABLE `shop`.`books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(70) NOT NULL,
  `author` varchar(70) DEFAULT NULL,
  `price` double NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`book_id`),
  KEY `book_id_key` (`book_id`),
  CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
);

--Create table: orders  
--Key: order_id
CREATE TABLE `shop`.`orders` (
  `order_id` bigint NOT NULL AUTO_INCREMENT,
  `delivery_name` varchar(70) NOT NULL,
  `delivery_address` varchar(70) NOT NULL,
  `cc_name` varchar(70) NOT NULL,
  `cc_number` varchar(32) NOT NULL,
  `cc_expiry` varchar(20) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `order_id_key` (`order_id`)
);

--Create table: order_details
--Key: id
--Contraints:
-- Don't let a book_id be entered into this table
--   if it doesn't exist in books table  
-- Dont let an order_id be entered into this table 
--   if it doesn't exist in the orders table
CREATE TABLE `shop`.`order_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `title` varchar(70) NOT NULL,
  `author` varchar(70) DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_details_id_key` (`id`),
  CONSTRAINT `book_id` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
); 