DROP TABLE IF EXISTS demo.calendar CASCADE; 
CREATE TABLE demo.calendar (cdate DATE)  
DISTRIBUTED BY (cdate); 

INSERT INTO demo.calendar (cdate) 
SELECT GENERATE_SERIES(0, max(review_date) - min(review_date)) + min(review_date) 
FROM ( 
	SELECT review_date 
	FROM demo.amzn_reviews 
	GROUP BY review_date) A; 

ALTER TABLE demo.calendar ADD COLUMN from_mtd date; 
ALTER TABLE demo.calendar ADD COLUMN from_ytd date; 

UPDATE demo.calendar 
SET from_mtd = (EXTRACT(YEAR FROM cdate) || '-' || EXTRACT(MONTH FROM cdate) || '-1')::date, 
	from_ytd = (EXTRACT(YEAR FROM cdate) || '-1-1')::date; 
 
CREATE VIEW demo.calendar_MTD AS 
SELECT C1.cdate, C2.cdate AS cdate_mtd 
FROM demo.calendar C1 
	INNER JOIN demo.calendar C2 
		ON C1.cdate >= C2.cdate 
		AND C1.from_mtd = C2.from_mtd 
		AND C1.from_ytd = C2.from_ytd; 

ANALYSE demo.calendar; 