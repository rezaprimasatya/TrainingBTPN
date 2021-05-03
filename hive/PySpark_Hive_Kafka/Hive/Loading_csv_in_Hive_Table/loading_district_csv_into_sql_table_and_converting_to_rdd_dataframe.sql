## to load data from csv to a sql table

DROP TABLE IF EXISTS district_raw;
CREATE TABLE district_raw
(
   id INT,
   name STRING,
   place STRING,
   acc INT,
   a1 DECIMAL,
   a2 DECIMAL,
   a3 DECIMAL,
   a4 DECIMAL,
   a5 DECIMAL,
   a6 DECIMAL,
   a7 DECIMAL,
   a8 DECIMAL,
   a9 DECIMAL,
   a10 DECIMAL,
   a11 DECIMAL,
   a12 DECIMAL
   )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ';' STORED AS TEXTFILE; 
  
LOAD DATA LOCAL INPATH '/home/cloudera/district.csv' INTO TABLE district_raw;


#### to convert to sequence file

DROP TABLE IF EXISTS district_seq;
CREATE TABLE district_seq
(
   id INT,
   name STRING,
   place STRING,
   acc INT,
   a1 DECIMAL,
   a2 DECIMAL,
   a3 DECIMAL,
   a4 DECIMAL,
   a5 DECIMAL,
   a6 DECIMAL,
   a7 DECIMAL,
   a8 DECIMAL,
   a9 DECIMAL,
   a10 DECIMAL,
   a11 DECIMAL,
   a12 DECIMAL
)
STORED AS SEQUENCEFILE LOCATION '/user/practice/district_seq';
 
INSERT INTO TABLE district_seq SELECT id, name, place, acc, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12 FROM district_raw;


## LOAD FILE IN rdd in scala spark shell
import org.apache.hadoop.io._
val file = sc.sequenceFile[BytesWritable, String]("hdfs:////user/practice/district_seq")

sc.sequenceFile[BytesWritable, String]("hdfs:////user/practice/district_seq").map(p => p.toString()).collect

## load file in pyspark shell
from pyspark.sql.functions import input_file_name 
df = sc.sequenceFile("hdfs:////user/practice/district_seq").toDF()
