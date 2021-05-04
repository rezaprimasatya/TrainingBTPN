SELECT 
    `department_id`, COUNT(`id`) AS `Number of employees`
FROM
    `employees`
GROUP BY `department_id`;



SELECT 
    `department_id`,
    ROUND(AVG(`salary`), 2) AS `Number of employees`
FROM
    `employees`
GROUP BY `department_id`;



SELECT 
    `department_id`, ROUND(MIN(`salary`), 2) AS `Min_Salary`
FROM
    `employees`
GROUP BY `department_id`
HAVING `Min_Salary` > 800
ORDER BY `department_id`;


SELECT 
     count(`price`) as sum
FROM
   `products`
WHERE
   `category_id` = 2 AND `price` > 8;



SELECT 
    `category_id`,
    ROUND(AVG(price), 2) AS 'Average price',
    ROUND(MIN(price), 2) AS 'Cheapest Product',
    ROUND(MAX(price), 2) AS 'Most Expensive Product'
FROM
    `products`
GROUP BY `category_id`;




