DROP TABLE IF EXISTS demo.amzn_reviews_by_marketplace; 
 
CREATE TABLE demo.amzn_reviews_by_marketplace ( 
	marketplace text NULL, 
	customer_id int8 NULL, 
	review_id text NULL, 
	product_id text NULL, 
	product_parent int8 NULL, 
	product_title text NULL, 
	product_category text NULL, 
	star_rating int4 NULL, 
	helpful_votes int4 NULL, 
	total_votes int4 NULL, 
	vine text NULL, 
	verified_purchase text NULL, 
	review_headline text NULL, 
	review_body text NULL, 
	review_date date NULL 
) 
DISTRIBUTED BY (marketplace); 
 
INSERT INTO demo.amzn_reviews_by_marketplace 
SELECT * FROM demo.amzn_reviews; 
