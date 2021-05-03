DROP DATABASE IF EXISTS TTN;
CREATE DATABASE TTN;
USE TTN;

CREATE TABLE titanic_3
(
   pclass INT,
   survived INT,
   name VARCHAR(20),
   sex VARCHAR(20),
   age DECIMAL(10,5),
   sibsb INT,
   parch INT,
   ticket VARCHAR(20),
   fare DECIMAL(20,6),
   cabin VARCHAR(20),
   embarked CHAR(1),
   boat INT,
   destination VARCHAR(30)
   )
  
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "seperatorChar" = ',',
    "quoteChar" = '"'
    )
STORED AS TEXTFILE;

LOAD DATA INPATH 
'/user/cloudera/titanic.txt' 
INTO TABLE titanic_3;

SELECT * FROM titanic_3 LIMIT 10;