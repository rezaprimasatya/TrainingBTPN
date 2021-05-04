CREATE TABLE `mountains` (
    `id` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `peaks` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `mountain_id` INT(11),
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
);




SELECT 
    v.`driver_id`,
    v.`vehicle_type`,
    CONCAT_WS(' ', c.first_name, c.last_name) AS `driver_name`
FROM
    `campers` AS c
        JOIN
    `vehicles` AS v ON c.`id` = v.`driver_id`;
    
    
  
  
SELECT 
    r.`starting_point` AS `route_starting_point`,
    r.`end_point` AS `route_ending_point`,
    r.`leader_id`,
    CONCAT_WS(' ', c.`first_name`, c.`last_name`) AS `leader_name`
FROM
    `routes` AS r
        JOIN
    `campers` AS c ON r.`leader_id` = c.`id`; 
  
  
  
  DROP TABLES `peaks`,`mountains`;
  
  CREATE TABLE `mountains` (
    `id` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL

);

CREATE TABLE `peaks` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `mountain_id` INT(11),
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
        ON UPDATE CASCADE ON DELETE CASCADE
);



 
     
 
