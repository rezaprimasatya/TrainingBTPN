SELECT
	tableoid::regclass AS partition_name, 
	count(*) AS row_count 
FROM
	demo.amzn_reviews_partitioned 
GROUP BY 1 
ORDER BY 1;
