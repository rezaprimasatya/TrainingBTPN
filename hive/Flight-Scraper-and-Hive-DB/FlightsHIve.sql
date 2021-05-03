CREATE TABLE IF NOT EXISTS flights (id_flight STRING, 
 callsign VARCHAR(20), 
 operated_by VARCHAR(100), 
 origin VARCHAR(200), 
 destination VARCHAR(200), 
 aircraft VARCHAR(100), 
 altitude INT, 
 latitude DECIMAL(9,6), 
 longitude DECIMAL(9,6), 
 positionTime BIGINT, 
 speed DECIMAL(4,1), 
 vsi INT)
 ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

  LOAD DATA LOCAL INPATH '/opt/flightsMAD.csv' INTO TABLE flights;