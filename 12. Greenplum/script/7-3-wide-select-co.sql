EXPLAIN ANALYZE 
SELECT marketplace, 
	customer_id, 
	product_id, 
	product_title, 
	product_parent, 
	product_category, 
	star_rating, 
	helpful_votes, 
	total_votes, 
	vine, 
	verified_purchase, 
	review_headline, 
	review_body 
FROM demo.amzn_reviews_co 
WHERE DATE_PART('year', review_date) BETWEEN 2000 AND 2005;
