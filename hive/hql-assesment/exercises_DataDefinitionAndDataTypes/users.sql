CREATE SCHEMA `demo`;

CREATE TABLE `users`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`username` VARCHAR(30) NOT NULL,
`password` VARCHAR(26) NOT NULL,
`profile_picture` BLOB , 
`last_login_time` DATETIME,
`is_deleted` BOOLEAN NOT NULL
);


INSERT INTO `users`(`username`, `password`,`is_deleted`)
VALUES
( 'Verccety', 'pass34' , false),
( 'mangusta', 'pass_.34' , false),
( 'crazzyGirl', '_@pass!34' , false),
( 'ocean', 'r1membaaa:!@#' , false),
( 'winner', 'raPas007' , false);


ALTER TABLE`users`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `username`);

ALTER TABLE `users`
CHANGE COLUMN `last_login_time` `last_login_time` TIME;

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`);

ALTER TABLE `users`
ADD CONSTRAINT uc_username
UNIQUE (`username`);

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT fk_users
 PRIMARY KEY (`id`);


