EXPLAIN ANALYZE 
SELECT COUNT(*), 
cdate_mtd 
FROM demo.amzn_reviews, 
	demo.calendar_mtd 
WHERE 
	amzn_reviews.review_date = calendar_mtd.cdate_mtd 
	AND cdate = '2015-03-25'::DATE 
GROUP BY cdate_mtd 
ORDER BY cdate_mtd;