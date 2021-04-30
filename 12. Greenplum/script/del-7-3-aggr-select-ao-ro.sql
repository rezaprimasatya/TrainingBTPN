EXPLAIN ANALYZE 
SELECT COUNT(*), 
	marketplace, 
	product_category, star_rating 
FROM demo.amzn_reviews_ao_ro_zlib3
WHERE 
	DATE_PART('year', review_date) BETWEEN 2000 AND 2005 
GROUP BY 2, 3, 4;
