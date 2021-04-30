EXPLAIN ANALYZE 
SELECT COUNT(*), 
	ROUND(AVG(helpful_votes)) AS helpful_votes_avg, 
	ROUND(AVG(total_votes)) AS total_votes_Avg,
	marketplace, 
	product_category, 
	star_rating, 
	verified_purchase, 
	CASE WHEN LENGTH(review_headline)<= 20 THEN 'Short Headline' ELSE 'Long Headline' END AS review_headline_length_type,
	CASE WHEN LENGTH(review_body)<= 400 THEN 'Short Body' ELSE 'Long Body' END AS review_body_length_type
FROM demo.amzn_reviews_ro 
GROUP BY 4, 5, 6, 7, 8, 9; 