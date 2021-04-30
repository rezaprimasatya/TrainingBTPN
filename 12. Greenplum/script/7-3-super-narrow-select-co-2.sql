EXPLAIN ANALYZE 
SELECT review_body 
FROM demo.amzn_reviews_co 
WHERE DATE_PART('year', review_date) BETWEEN 2000 AND 2005; 