DROP VIEW IF EXISTS demo.travel_speed; 
 
CREATE VIEW demo.travel_speed AS 
SELECT 
    qoy, 
    hod, 
    sourceid, 
    dstid,  
    uml.mean_travel_time, 
    ROUND(((10 * ST_Distance(ST_Centroid(ll1.geometry), ST_Centroid(ll2.geometry)) * 111257) / (36 * uml.mean_travel_time))::NUMERIC, 5) AS ST_Kmph, 
    ROUND((10 * ST_Distance(ST_Centroid(ll1.geometry), ST_Centroid(ll2.geometry)) * 111257)::NUMERIC, 5) AS ST_DistanceKm 
FROM demo.uber_mov_ldn AS uml 
INNER JOIN demo.london_lsoa AS ll1 
    ON uml.sourceid = ll1.movement_id 
INNER JOIN demo.london_lsoa AS ll2 
    ON uml.dstid = ll2.movement_id; 
 
DROP TABLE IF EXISTS demo.ldn_max_kmph_per_ts_src_dst; 
     
CREATE TABLE demo.ldn_max_kmph_per_ts_src_dst AS 
SELECT A.* 
FROM ( 
    SELECT qoy, hod, sourceid, dstid, MAX(ST_Kmph) AS max_kmph 
    FROM demo.travel_speed 
    GROUP BY qoy, hod, sourceid, dstid) A, ( 
    SELECT qoy, hod, MAX(ST_Kmph) AS max_kmph 
    FROM demo.travel_speed 
    GROUP BY qoy, hod) B 
WHERE 
    A.qoy = B.qoy 
    AND A.hod = B.hod 
    AND A.max_kmph = B.max_kmph 
DISTRIBUTED BY (sourceid, dstid); 
     
DROP TABLE IF EXISTS demo.ldn_max_distancekm_per_ts_src_dst; 
     
CREATE TABLE demo.ldn_max_distancekm_per_ts_src_dst AS 
SELECT A.* 
FROM ( 
    SELECT qoy, hod, sourceid, dstid, MAX(ST_DistanceKm) AS max_distancekm 
    FROM demo.travel_speed 
    GROUP BY qoy, hod, sourceid, dstid) A, ( 
    SELECT qoy, hod, MAX(ST_DistanceKm) AS max_distancekm 
    FROM demo.travel_speed 
    GROUP BY qoy, hod) B 
WHERE 
    A.qoy = B.qoy 
    AND A.hod = B.hod 
    AND A.max_distancekm = B.max_distancekm 
DISTRIBUTED BY (sourceid, dstid); 
 
DROP TABLE IF EXISTS demo.ldn_min_kmph_per_ts_src_dst; 
     
CREATE TABLE demo.ldn_min_kmph_per_ts_src_dst AS 
SELECT A.* 
FROM ( 
    SELECT qoy, hod, sourceid, dstid, MIN(ST_Kmph) AS min_kmph 
    FROM demo.travel_speed 
    GROUP BY qoy, hod, sourceid, dstid) A, ( 
    SELECT qoy, hod, MIN(ST_Kmph) AS min_kmph 
    FROM demo.travel_speed 
    GROUP BY qoy, hod) B 
WHERE 
    A.qoy = B.qoy 
    AND A.hod = B.hod 
    AND A.min_kmph = B.min_kmph 
DISTRIBUTED BY (sourceid, dstid); 
     
DROP TABLE IF EXISTS demo.ldn_min_distancekm_per_ts_src_dst; 
     
CREATE TABLE demo.ldn_min_distancekm_per_ts_src_dst AS 
SELECT A.* 
FROM ( 
    SELECT qoy, hod, sourceid, dstid, MIN(ST_DistanceKm) AS min_distancekm 
    FROM demo.travel_speed 
    GROUP BY qoy, hod, sourceid, dstid) A, ( 
    SELECT qoy, hod, MIN(ST_DistanceKm) AS min_distancekm 
    FROM demo.travel_speed 
    GROUP BY qoy, hod) B 
WHERE 
    A.qoy = B.qoy 
    AND A.hod = B.hod 
    AND A.min_distancekm = B.min_distancekm 
DISTRIBUTED BY (sourceid, dstid); 