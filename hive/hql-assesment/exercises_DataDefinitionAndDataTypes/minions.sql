CREATE SCHEMA `minions`;


CREATE TABLE `minions`(
`id` INT  NOT NULL PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`age` INT
);

CREATE TABLE `towns`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

ALTER TABLE `minions`
ADD COLUMN `town_id` INT,
ADD CONSTRAINT `fk_minions_towns`
 FOREIGN KEY (`town_id`)
 REFERENCES `towns` (`id`);

INSERT INTO `towns`
VALUES 
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

INSERT INTO `minions`
VALUES 
(1,	'Kevin',22,	1),
(2,'Bob',15,3),
(3,'Steward',NULL,2);


DELETE FROM `minions`; /*delete only data in the table*/

INSERT INTO `minions`
VALUES 
(1,	'Kevin',22,	1),
(2,'Bob',15,3),
(3,'Steward',NULL,2);

TRUNCATE TABLE `minions`; /* only entyties but foreign key keep*/

INSERT INTO `minions`
VALUES 
(1,	'Kevin',22,	1),
(2,'Bob',15,3),
(3,'Steward',NULL,2);

DROP TABLE `minions`; /* delete all table - it`s going out*/ 
DROP TABLE `towns`; 



