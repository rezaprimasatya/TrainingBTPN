CREATE TABLE demo.uber_mov_ldn (
    qoy INTEGER, 
    sourceid INTEGER, 
    dstid INTEGER, 
    hod INTEGER, 
    mean_travel_time NUMERIC, 
    standard_deviation_travel_time NUMERIC, 
    geometric_mean_travel_time NUMERIC, 
    geometric_standard_deviation_travel_time NUMERIC
) 
DISTRIBUTED BY (sourceid, dstid) 
PARTITION BY LIST (qoy) 
SUBPARTITION BY RANGE (hod) 
SUBPARTITION TEMPLATE (
    START (0) END (23) EVERY (1), DEFAULT SUBPARTITION OTHERHOD) 
(VALUES (201601, 201602, 201603, 201604, 201701, 201702, 201703, 201704, 201801), DEFAULT PARTITION OTHERQOY);

CREATE TABLE demo.postcode_lookup (
    pcd7 TEXT, 
    pcd8 TEXT, 
    pcds TEXT, 
    dointr TEXT, 
    doterm TEXT, 
    usertype TEXT, 
    oa11cd TEXT, 
    lsoa11cd TEXT, 
    msoa11cd TEXT, 
    ladcd TEXT, 
    lsoa11nm TEXT, 
    msoa11nm TEXT, 
    ladnm TEXT, 
    ladnmw TEXT) 
DISTRIBUTED RANDOMLY;

CREATE TABLE demo.postcodelatlng (
    id INT, 
    postcode VARCHAR(8), 
    latitude DECIMAL(18,15), 
    longitude DECIMAL(18,15)) 
DISTRIBUTED BY (id);
                      
CREATE TABLE demo.dft_traffic_counts_raw (
    count_point_id INTEGER, 
    direction_of_travel CHAR(1), 
    YEAR SMALLINT, 
    count_date TEXT, 
    HOUR SMALLINT, 
    region_id INTEGER, 
    region_name TEXT, 
    region_ons_code TEXT, 
    local_authority_id INTEGER, 
    local_authority_name TEXT, 
    local_authoirty_ons_code TEXT, 
    road_name TEXT, 
    road_category VARCHAR(3), 
    road_type TEXT, 
    start_junction_road_name TEXT, 
    end_junction_road_name TEXT, 
    easting BIGINT, 
    northing BIGINT, 
    latitude NUMERIC(18,15), 
    longitude NUMERIC(18,15), 
    link_length_km NUMERIC, 
    link_length_miles NUMERIC, 
    pedal_cycles INTEGER, 
    two_wheeled_motor_vehicles INTEGER, 
    cars_and_taxis INTEGER, 
    buses_and_coaches INTEGER, 
    lgvs INTEGER, 
    hgvs_2_rigid_axle INTEGER, 
    hgvs_3_rigid_axle INTEGER, 
    hgvs_4_or_more_rigid_axle INTEGER, 
    hgvs_3_or_4_articulated_axle INTEGER, 
    hgvs_5_articulated_axle INTEGER, 
    hgvs_6_articulated_axle INTEGER, 
    all_hgvs INTEGER, 
    all_motor_vehicles INTEGER) 
DISTRIBUTED BY (count_point_id);
                      
CREATE TABLE demo.london_lsoa ( 
    dat_type text NULL, 
    geometry geometry NULL, 
    msoa_code text NULL, 
    msoa_name text NULL, 
    la_code text NULL, 
    la_name text NULL, 
    geoeast int4 NULL, 
    geonorth int4 NULL, 
    popeast int4 NULL, 
    popnorth int4 NULL, 
    area_km2 numeric NULL, 
    movement_id int4 NULL, 
    display_name text NULL 
) 
DISTRIBUTED BY (movement_id); 
  
CREATE TABLE demo.london_lsoa_txt ( 
    input TEXT) 
DISTRIBUTED RANDOMLY; 