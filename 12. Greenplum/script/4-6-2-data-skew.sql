SELECT
	skcc.skcnamespace as schemaname,
	skcc.skcrelname as tablename, 
	skcc.skccoeff as coefficient 
FROM
	gp_toolkit.gp_skew_coefficients skcc 
WHERE
	skcc.skcnamespace || '.' || skcc.skcrelname = 'demo.amzn_reviews';
