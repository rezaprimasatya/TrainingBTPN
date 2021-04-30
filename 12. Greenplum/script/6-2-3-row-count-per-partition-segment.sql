SELECT
	tableoid::regclass as partition_name, 
	gp_segment_id as segment_id, 
	count(*) AS segment_count, 
	SUM(COUNT(*)) OVER (PARTITION BY tableoid::regclass) AS partition_count 
FROM 
	demo.amzn_reviews_partitioned 
GROUP BY 1, 2 
ORDER BY 1, 2;
