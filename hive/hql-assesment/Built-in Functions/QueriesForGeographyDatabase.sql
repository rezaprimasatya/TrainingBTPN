SELECT 
    `country_name`, `iso_code`
FROM
    `countries`
WHERE
    `country_name` LIKE '%a%a%a%'
ORDER BY `iso_code`;


SELECT 
    p.`peak_name`,
    r.`river_name`,
    LOWER(CONCAT(p.`peak_name`,
                    SUBSTRING(r.`river_name`, 2))) AS mix
FROM
    `peaks` AS p,
    `rivers` AS r
WHERE
    RIGHT(p.`peak_name`, 1) = LEFT(r.`river_name`, 1)
ORDER BY `mix`;