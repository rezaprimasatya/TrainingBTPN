EXPLAIN 
SELECT 
	sales.cdate, 
	sum(qty) OVER (ORDER BY sales.cdate), 
	sum(revenue) OVER (ORDER BY sales.cdate) 
FROM 
	demo.sales 
	JOIN demo.calendar 
		ON sales.cdate = calendar.cdate 
ORDER BY 
	sales.cdate;
