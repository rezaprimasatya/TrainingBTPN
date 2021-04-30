SELECT 'demo' AS schemaname, 'amzn_reviews' AS tablename, pg_size_pretty(pg_relation_size('demo.amzn_reviews')) AS size, 'Disk space used by the table or index.' AS level 
UNION ALL 
SELECT 'demo' AS schemaname, 'amzn_reviews' AS tablename, pg_size_pretty(pg_total_relation_size('demo.amzn_reviews')) AS size, 'Total disk space used by the table, including indexes and toasted data.' AS level;
