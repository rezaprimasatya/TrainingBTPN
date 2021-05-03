# Hive Syntax Cheat Sheet

## General rule

- interchangeable constructs
- hive is case sensitive
- secmicolon to terminate statements

## Hive Data Types

### Primitive Data Types

- Numeric
    - TINYINT, SMALLINT, INT, BIGINT
    - FLOAT
    - DOUBLE
    - DECIMAL

- Date/Time
    - TIMESTAMP
        - Strings must be in format "YYYY-MM-DD HH:MM:SS.fffffffff"
        - Interger types as UNIX timestamp in seconds from UNIX epoch (1-JAN-1970 00:00:00)
        - Floating point types same as Integer with decimal precision
    - DATE

- String Data Types
    - STRING
    - VARCHAR
    - CHAR

- Misc.
    - BOOLEAN
    - BINARY
        - BINARY is an array of Bytes and similar to VARBINARY in many RDBMSs. BINARY columns are stored within the record, not separately like BLOBs . We can include arbitrary bytes in BINARY column and these bytes are not parsed by Hive as numbers or strings.

### Complex/Collection Types

|Type|Syntax|
|---|---|   
|Arrays|ARRAY<data_type>|
|Maps|MAP<primitive_type,data_type>|
|Struc|STRUCT<col_name:data_type [COMMENT col_comment], ...>|
|Union Type|UNIONTYPE<data_type, data_type, ...>|
|||

- Default delimeters for the fields in collection data types

    |Delimiter|Code|Description|
    |---|---|---|
    |\n|\n|Record or row delimiter|
    |^A (Ctrl + A)|Field delimiter|Field delimiter|
    |^B (Ctrl + B)|\002|Element delimiter in ARRAY and STRUCTs|
    |^C (Ctrl + C)|\003|Delimits key/value pairs in a MAP|
    ||||

- Example

```
CREATE TABLE movies (
    movie_name           string,
    participants         ARRAY<string>,
    release_dates        MAP<string, timestamp>,
    studio_addr          STRUCT<state:string, city:string, zip:string>,
    complex_participants MAP<string, STRUCT<address:string, attributes MAP<string, string>>>,
    misc                 UNIONTYPE <int, string, ARRAY<double>>
);

SELECT
    movie_name,
    participants[0],
    release_dates["USA"],
    studio_addr.zip,
    complex_participants["Leonardo DiCaprio"].attributes["fav_color"],
    misc
FROM
    movies;
```
- sample output:

    |x|x|x|x|x|
    |---|---|---|---|---|
    |"Inception"|2010-07-16 00:00:00|91505|"Dark Green"|{0:800}|
    |"Planes"|2013-08-09 00:00:00|91505|"Green"|{2:[1.0,2.3,5.6]}|

```
CREATE TABLE user (
    name      STRING,
    id        BIGINT,
    isFTE     BOOLEAN,
    role      VARCHAR(64),
    salary    DECIMAL(8,2),
    phones    ARRAY<INT>,
    deductions MAP<CHAR, FLOAT>,
    address   STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>,
    others    UNIONTYPE<FLOAT,BOOLEAN,STRING>,
    misc      BINARY
)
ROW FORMAT DELIMITED 
    FIELDS TERMINATED BY '\001'
    COLLECTION ITEMS TERMINATED BY '\002'
    MAP KEYS TERMINATED BY '\003'
    LINES TERMINATED BY '\n';
```

## Basic Syntax

### Database

- Create database

```
CREATE (DATABASE|SCHEMA) [IF NOT EXISTS] database_name
    [COMMENT some_comment]
    [LOCATION hdfs_path]
    [WITH DBPROPERTIES(property_name=property_value, ...)];
```

- Use database

```
USE db_name;
```

- Drop database

```
DROP (DATABASE|SCHEMA) [IF EXISTS] database_name;
```
- Show database

```
SHOW DATABASES;
```

### Table

- Create table

```
CREATE [EXTERNAL] TABLE [IF NOT EXISTS] [db_name.]table_name
    [(col_name data type [COMMENT col_comment], ...)]
    [PARTITIONED BY (col_name data type [COMMENT col_comment], ...)]
    [ROW FORMATTED row_format]
    [STORED AS file_format]
    [LOCATION hdfs_path]
    [TBLPROPERTIES (property_name=property_value, ...)];

External Example 1:

    CREATE EXTERNAL TABLE users (
        user_id INT,
        age INT,
        gender STRING,
        occupation STRING,
        zip_code STRING
    )
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '|'
    STORED AS TEXTFILE
    LOCATION '/pluralsight/userinfo'
    ;

    ==> For external table, you still can directly insert data into it via "INSERT INTO TABLE ..." syntax. This is same as managed table: You can use "INSERT INTO TABLE ..." to insert data to __both__ managed table and external table

Create table **AS** Example 1:
    CREATE TABLE 
        occupation_count STORED AS RCFile 
    AS 
    SELECT 
        COUNT(*), occupation 
    FROM users 
    GROUP BY 
        occupation;

    ==> new table will have data

Create table **LIKE** Example 1:

    CREATE TABLE 
        occupation2 
    LIKE occupation_count;

    ==> It will create a new table with no records (empty)
    ==> It is similar to Oracle "CREATE TABLE y AS SELECT * FROM y WHERE 1=0"
```

- Truncate table
    - there is no "IF NOT EXISTS" as part of truncate syntax

```
TRUNCATE TABLE table_name [PARTITION partition_spec];
```


- Drop table

```
DROP TABLE IF EXISTS [db_name.]table_name;
```

- Show table in hive database

```
SHOW TABLES [IN database_name] ['identifier_with_wildcards'];

example:

    SHOW TABLES "*example*";
```

- Describe table

```
DESCRIBE [EXTENDED|FORMATTED] [db_name.]table_name;
```


- Show table DDL script

```
SHOW CREATE TABLE [db_name.]table_name;
```

- Show execution plan for Hive query

```
EXPLAIN query; 
```

---



### Load Data into table

- ```LOAD PATH INPATH [path]```
    - Move data if source is HDFS
    - Copies data if source is LOCAL
        - ```LOAD DATA LOCAL INPATH [path]```

---

### Partitioning in Hive

- Advantages

    Partitioning is used for distributing execution load horizontally.
    As the data is stored as slices/parts, query response time is faster to process the small part of the data instead of looking for a search in the entire data set.
    For example, In a large user table where the table is partitioned by country, then selecting users of country ‘IN’ will just scan one directory ‘country=IN’ instead of all the directories.

- Limitations

    Having too many partitions in table creates large number of files and directories in HDFS, which is an overhead to NameNode since it must keep all metadata for the file system in memory only.

    Partitions may optimize some queries based on Where clauses, but may be less responsive for other important queries on grouping clauses.

    In Mapreduce processing, Huge number of partitions will lead to huge no of tasks (which will run in separate JVM) in each mapreduce job, thus creates lot of overhead in maintaining JVM start up and tear down. For small files, a separate task will be used for each file. In worst scenarios, the overhead of JVM start up and tear down can exceed the actual processing time.



#### Managed Partitioned Tables

```
CREATE TABLE table_name (col_name_1 data_type_1, ....) 
PARTITIONED BY (col_name_n data_type_n [COMMENT col_comment], ...);

- Example


    CREATE TABLE partitioned_user(
        firstname VARCHAR(64),
        lastname  VARCHAR(64),
        address   STRING,
        city 	  VARCHAR(64),
        post      STRING,
        phone1    VARCHAR(64),
        phone2    STRING,
        email     STRING,
        web       STRING
        )
    PARTITIONED BY (country VARCHAR(64), state VARCHAR(64))
    STORED AS SEQUENCEFILE;

```

        ==> Note that we didn’t include country and state columns in table definition but included in partition definition.

#### External Partitioned Tables

CREATE EXTERNAL TABLE table_name (col_name_1 data_type_1, ....) 
PARTITIONED BY (col_name_n data_type_n [COMMENT col_comment], ...);

We can create external partitioned tables as well, just by using the EXTERNAL keyword in the CREATE statement, but for creation of External Partitioned Tables, we do not need to mention LOCATION clause as we will mention locations of each partitions separately while inserting data into table.   

#### Inserting Data Into Partitioned Tables


Data insertion into partitioned tables can be done in two modes.

    - Static Partitioning
    - Dynamic Partitioning

- Static Partition in Hive

    In this mode, input data should contain the columns listed only in table definition but not the columns defined in partitioned by clause.

    1. Loading Data into Managed Partitioned Table From Local FS

    ```
    -- Example
    hive> LOAD DATA LOCAL INPATH '${env:HOME}/staticinput.txt'
          INTO TABLE partitioned_user
          PARTITION (country = 'US', state = 'CA');

    This will create separate directory under the default warehouse directory in HDFS.

        /user/hive/warehouse/partitioned_user/country=US/state=CA/
    
    Similarly we have to add other partitions, which will create corresponding directories in HDFS. Or else we can load the entire directory into Hive table with single command and can add partitions for each file with ALTER command.

    
    hive> LOAD DATA LOCAL INPATH '${env:HOME}/inputdir'
          INTO TABLE partitioned_user;
    
    ```

    1. Loading Partition From Other Table

    ```
    -- Example 
    hive> INSERT OVERWRITE TABLE partitioned_user
        PARTITION (country = 'US', state = 'AL')
        SELECT * FROM another_user au 
        WHERE au.country = 'US' AND au.state = 'AL';
    ```

    ==> Overwriting Existing Partition

        We can overwrite an existing partition with help of OVERWRITE INTO TABLE partitioned_user clause.   

    1. Loading Data into External Partitioned Table from HDFS

    There is alternative for bulk loading of partitions into hive table. As data is already present in HDFS and should be made accessible by Hive, we will just mention the locations of the HDFS files for each partition.

    If our files are on Local FS, they can be moved to a directory in HDFS and we can add partition for each file in that directory with commands similar to below.

    ```
    hive> ALTER TABLE partitioned_user ADD PARTITION (country = 'US', state = 'CA')
        LOCATION '/hive/external/tables/user/country=us/state=ca'
    ```

    Similarly we need to repeat the above alter command for all partition files in the directory so that a meta data entry will be created in metastore, mapping the partition and table.

- Dynamic Partitioning in Hive

    Instead of loading each partition with single SQL statement as shown above, which will result in writing lot of SQL statements for huge no of partitions, Hive supports dynamic partitioning with which we can add any number of partitions with single SQL execution. Hive will automatically splits our data into separate partition files based on the values of partition keys present in the input files.

    For dynamic partition loading we will not provide the values for partition keys

    ```
    - Example
    
    hive>INSERT INTO TABLE partitioned_user
         PARTITION (country, state)
            SELECT  
                firstname ,
                lastname  ,
                address   ,
                city      ,
                post      ,
                phone1    ,
                phone2    ,
                email     ,
                web       ,
                country   ,
                state     
         FROM temp_user;
    ```

    ==> We can also __mix__ dynamic and static partitions by specifying it as PARTITION(country = ‘US’, state). But __static partition keys must come before__ the dynamic partition keys.

    ==> But by default, Dynamic Partitioning is disabled in Hive to prevent accidental partition creations. To use dynamic partitioning we need to set below properties either in Hive Shell or in hive-site.xml file.

    [Please check here for dynamic partition settings](https://gist.github.com/kzhangkzhang/7c33f779452348222561a31bd6faabcd)

    We can set these through hive shell with below commands:

    ```
    set hive.exec.dynamic.partition=true;
    set hive.exec.dynamic.partition.mode=nonstrict;
    set hive.exec.max.dynamic.partitions=1000;
    set hive.exec.max.dynamic.partitions.pernode=1000;
    ```
---

### Select Statement

- Distinct

```
SELECT DISTINCT 
    col1,
    col2,
    col3
FROM
    some_table;
```

- Aliasing

```
SELECT
    col1 + col2 AS col3
FROM
    some_table;
```

- REGEX Column Specification

```
SELECT 
    '(ID|Name)?+.+'
FROM
    some_table;
```

- Inerchangeable constructs

```
SELECT 
    col1,
    col2,
    col3
FROM
    some_table
WHERE
    where_condition
LIMIT
    number_of_records;

above is same as below


FROM
    some_table
SELECT 
    col1,
    col2,
    col3
WHERE
    where_condition
LIMIT
    number_of_records;

```

- Sub queries & Union

```
SELECT 
    t3.mycol
FROM
    (
        SELECT
            col_a + col_b AS mycol
        FROM
            some_table
        UNION ALL
        SELECT
            col_y AS mycol
        FROM
            another_table
    ) t3
JOIN t4 on (t4.col_x = t3.mycol);
```

## Miscellaneous

### Hive Shell

- execute host command within hive shell

```
hive>!host_command;

for example:

    hive>!clear;
    hive>!pwd;
    hive>~hdfs dfs -ls;
```

- show all Hive setting with hive shell

```
hive>set;
```
