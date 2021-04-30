SELECT * 
FROM (SELECT gp_segment_id::INT AS "Segment ID", 
  count(*)::INT AS "Row Count", 
	'demo.amzn_reviews' AS "Table Name" 
FROM 
  demo.amzn_reviews 
GROUP BY 1) A 
UNION ALL 
SELECT * 
FROM ( 
SELECT gp_segment_id::INT AS "Segment ID", 
  count(*)::INT AS "Row Count", 
	'demo.amzn_reviews_by_marketplace' AS "Table Name" 
FROM 
  demo.amzn_reviews_by_marketplace 
GROUP BY 1) B 
ORDER BY 1, 3