SELECT 
	partitionboundary, 
	partitiontablename, 
	partitionname, 
	partitionlevel, 
	partitionrank 
FROM pg_partitions 
WHERE tablename='amzn_reviews_partitioned';
