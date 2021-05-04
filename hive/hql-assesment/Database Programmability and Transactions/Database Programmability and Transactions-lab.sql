#1
CREATE DEFINER=`root`@`localhost` FUNCTION `ufn_count_employees_by_town`(town_name VARCHAR(45)) RETURNS int
    DETERMINISTIC
BEGIN

DECLARE count_town_ppl INT (11);

SET  `count_town_ppl` := (SELECT COUNT(e.employee_id) FROM employees AS e
       INNER JOIN `addresses` AS a 
        ON a.address_id = e.address_id
      INNER  JOIN `towns` AS t 
        ON a.town_id = t.town_id
WHERE  t.`name` = town_name); 

RETURN  count_town_ppl;
END

                                                                                           
SELECT UFN_COUNT_EMPLOYEES_BY_TOWN('Sofia') AS `count`;
                                                                                           

#2 
                                                                                           
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_raise_salaries`(`department_name` VARCHAR(45))
BEGIN
UPDATE `employees` AS e
        JOIN
    `departments` AS d ON d.department_id = e.department_id 
SET 
    e.`salary` = e.`salary` * 1.05
WHERE
    d.`name` = `department_name`;
END                                                                                     
 
CALL usp_raise_salaries('Finance');
                                                                                           
                                                                                           
 #3

CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_raise_salary_by_id`(id INT)
BEGIN
DECLARE does_exist INT;
START TRANSACTION;

UPDATE `employees` 
SET `salary` = `salary` * 1.05
WHERE `employee_id` = `id`;

SET does_exist := (SELECT COUNT(*) FROM employees WHERE employee_id = id);

IF does_exist > 0 THEN 
      COMMIT;
ELSE
      ROLLBACK;
END IF;
END
                                                                                           
                                                                                           
#4
                                                                                           
 CREATE TABLE `deleted_employees`(
 `employee_id` INT PRIMARY KEY AUTO_INCREMENT,
 `first_name` VARCHAR (50) NOT NULL,
 `last_name` VARCHAR (50) ,
 `middle_name` VARCHAR (50),
 `job_title` VARCHAR(50),
 `department_id` INT NOT NULL,
 `salary` DECIMAL (11,2) 
 );                                                                                           
                                                                                                                                                                                      
                                                                                          
CREATE DEFINER=`root`@`localhost` TRIGGER `tr_deleted_employees` AFTER DELETE ON `deleted_employees` FOR EACH ROW BEGIN
INSERT INTO deleted_employees 
    (first_name, last_name, middle_name, job_title, department_id, salary)
    VALUES (OLD.first_name, OLD.last_name, OLD.middle_name,
    OLD.job_title, OLD.department_id, OLD.salary);
END
                                                                                           
    
