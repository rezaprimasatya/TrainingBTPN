SELECT
	sif.sifnamespace as schemaname,
	sif.sifrelname as tablename, 
	sif.siffraction as fraction 
FROM
	gp_toolkit.gp_skew_idle_fractions sif 
WHERE
	sif.sifnamespace || '.' || sif.sifrelname = 'demo.amzn_reviews'
