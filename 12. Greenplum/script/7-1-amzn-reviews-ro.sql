DROP TABLE IF EXISTS demo.amzn_reviews_ro; 

CREATE TABLE demo.amzn_reviews_ro( 
  marketplace TEXT, 
  customer_id BIGINT, 
  review_id TEXT, 
  product_id TEXT, 
  product_parent BIGINT, 
  product_title TEXT, 
  product_category TEXT, 
  star_rating INTEGER, 
  helpful_votes INTEGER, 
  total_votes INTEGER, 
  vine TEXT, 
  verified_purchase TEXT, 
  review_headline TEXT, 
  review_body TEXT, 
  review_date DATE) 
DISTRIBUTED BY (review_id); 
