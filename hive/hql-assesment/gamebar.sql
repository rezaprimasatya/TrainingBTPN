CREATE SCHEMA `gamebar` ;

CREATE TABLE `employees`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(50) NOT NULL,
`last_name` VARCHAR(50) NOT NULL
);

CREATE TABLE `categories`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (50) NOT NULL
);

CREATE TABLE `products`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`category_id` INT NOT NULL
);

INSERT INTO `employees`
VALUES 
(1,'Test1','Test1'),
(2,'Test2','Test2'),
(3,'Test3','Test3');

ALTER TABLE `employees`
ADD COLUMN `midle_name` VARCHAR (50);

ALTER TABLE `products` 
ADD CONSTRAINT `my_fk`
  FOREIGN KEY (`category_id`)
  REFERENCES `categories` (`id`);
  
  ALTER TABLE `employees`
  MODIFY COLUMN `midle_name` VARCHAR (100);
  
  





