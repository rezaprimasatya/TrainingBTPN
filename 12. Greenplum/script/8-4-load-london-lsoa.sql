INSERT INTO demo.london_LSOA 
SELECT 
    dat_features->>'type' AS dat_type, 
    ST_GeomFromGeoJSON(dat_features->>'geometry') AS geometry, 
    ((dat_features->>'properties')::json)->>'msoa_code' AS msoa_code, 
    ((dat_features->>'properties')::json)->>'msoa_name' AS msoa_name, 
    ((dat_features->>'properties')::json)->>'la_code' AS la_code, 
    ((dat_features->>'properties')::json)->>'la_name' AS la_name, 
    (((dat_features->>'properties')::json)->>'geoeast')::INT AS geoeast, 
    (((dat_features->>'properties')::json)->>'geonorth')::INT AS geonorth, 
    (((dat_features->>'properties')::json)->>'popeast')::INT AS popeast, 
    (((dat_features->>'properties')::json)->>'popnorth')::INT AS popnorth, 
    (((dat_features->>'properties')::json)->>'area_km2')::NUMERIC AS area_km2, 
    (((dat_features->>'properties')::json)->>'MOVEMENT_ID')::INT AS movement_id, 
    ((dat_features->>'properties')::json)->>'DISPLAY_NAME' AS display_name 
FROM ( 
    SELECT JSON_ARRAY_ELEMENTS(dat->'features')::json AS dat_features 
    FROM ( 
        SELECT input::JSON AS dat 
        FROM demo.london_LSOA_TXT 
    ) A 
) foo; 

SELECT COUNT(*) FROM demo.london_lsoa; 