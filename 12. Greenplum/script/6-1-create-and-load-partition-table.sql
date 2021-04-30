DROP TABLE IF EXISTS demo.amzn_reviews_partitioned; 

CREATE TABLE demo.amzn_reviews_partitioned( 
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
DISTRIBUTED BY (review_id) 
PARTITION BY RANGE(review_date)( 
    START ('1995-01-01'::date) 
    END ('2015-12-31'::date) INCLUSIVE 
    EVERY ('1 year'::interval) 
); 

ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('1995-01-01') TO year1995; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('1996-01-01') TO year1996; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('1997-01-01') TO year1997; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('1998-01-01') TO year1998; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('1999-01-01') TO year1999; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2000-01-01') TO year2000; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2001-01-01') TO year2001; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2002-01-01') TO year2002; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2003-01-01') TO year2003; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2004-01-01') TO year2004; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2005-01-01') TO year2005; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2006-01-01') TO year2006; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2007-01-01') TO year2007; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2008-01-01') TO year2008; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2009-01-01') TO year2009; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2010-01-01') TO year2010; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2011-01-01') TO year2011; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2012-01-01') TO year2012; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2013-01-01') TO year2013; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2014-01-01') TO year2014; 
ALTER TABLE demo.amzn_reviews_partitioned RENAME PARTITION FOR ('2015-01-01') TO year2015; 
 
INSERT INTO demo.amzn_reviews_partitioned 
SELECT * FROM demo.amzn_reviews; 

ANALYSE demo.amzn_reviews_partitioned; 
 
SELECT COUNT(*) AS row_count, 'demo.amzn_reviews' tablename FROM demo.amzn_reviews 
UNION ALL 
SELECT COUNT(*) AS row_count, 'demo.amzn_reviews_partitioned' tablename FROM demo.amzn_reviews_partitioned;
