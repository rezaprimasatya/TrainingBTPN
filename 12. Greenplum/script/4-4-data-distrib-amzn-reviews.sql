SELECT gp_segment_id, 
  count(*) 
FROM
  demo.amzn_reviews 
GROUP BY 1 
ORDER BY 1;
