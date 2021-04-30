EXPLAIN 
SELECT 
	sales2.cdate, 
	sum(qty) OVER (ORDER BY sales2.cdate), 
	sum(revenue) OVER (ORDER BY sales2.cdate) 
FROM 
	demo.sales2 
	JOIN demo.calendar 
		ON sales2.cdate = calendar.cdate 
ORDER BY 
	sales2.cdate;
