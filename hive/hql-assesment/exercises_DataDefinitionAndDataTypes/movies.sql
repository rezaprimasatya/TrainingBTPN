CREATE SCHEMA `movies`;

USE `movies`;

CREATE TABLE `directors`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`director_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);

INSERT INTO `directors`(`director_name`)
VALUES
('Frank Sinatra'),
('Someone else'),
('Margarita Popova'),
('Maria Silvestar'),
('Muncho Munchew');

INSERT INTO `directors`(`director_name`, `notes`)
VALUES
('Sinan Sinatra', 'something');

CREATE TABLE `genres`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`genres_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);

INSERT INTO `genres`(`genres_name`, `notes`)
VALUES
('Comedy', 'funny'),
('Horrer', 'never wach it'),
('Trilar', NULL),
('Fantasy', 'stupped'),
('Romantic', 'love stories'),
('Action', 'fight');

CREATE TABLE categories(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(50) NOT NULL,
notes TEXT
);

INSERT INTO `categories`(`category_name`)
VALUES
('drama'),
('animation'),
('fantasy'),
('historical'),
('criminal');

CREATE TABLE `movies` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
`title` VARCHAR(100) UNICODE NOT NULL, 
`director_id` INT, 
`copyright_year` YEAR , 
`length` TIME, 
`genre_id` INT, 
`category_id` INT , 
`rating`DECIMAL, 
`otes` TEXT
);

ALTER TABLE `movies`
ADD CONSTRAINT fk_director_id
FOREIGN KEY  (`director_id`)
REFERENCES  `directors` (`id`) ,
ADD CONSTRAINT fk_genre_id
FOREIGN KEY  (`genre_id`)
REFERENCES  `genres` (`id`) ,
ADD CONSTRAINT fk_caregory_id
FOREIGN KEY  (`category_id`)
REFERENCES  `categories` (`id`);

INSERT INTO movies (title, director_id,copyright_year,genre_id,category_id) VALUES 
('First Weapon',1 ,'1993',1,1),
('Man In Pink',2 ,'1996',1,3),
('It Dev Dissaster',3 ,'1994',4,3),
('Rambo folling in love',4 ,'1991',1,1),
('Taxy 9',5 ,'1993',5,3);

