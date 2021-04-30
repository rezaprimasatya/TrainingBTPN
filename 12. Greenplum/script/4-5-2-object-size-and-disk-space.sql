SELECT pg_namespace.nspname AS schema,
	pg_class.relname AS relation, 
	pg_size_pretty(sotd.sotdsize::BIGINT) as tablesize, 
	pg_size_pretty(sotd.sotdtoastsize::BIGINT) as toastsize, 
	pg_size_pretty(sotd.sotdadditionalsize::BIGINT) as othersize, 
	pg_size_pretty(sotaid.sotaidtablesize::BIGINT) as tabledisksize, 
	pg_size_pretty(sotaid.sotaididxsize::BIGINT) as indexsize 
FROM pg_class 
	LEFT JOIN pg_stat_user_tables 
		ON pg_stat_user_tables.relid = pg_class.oid 
	LEFT JOIN gp_toolkit.gp_size_of_table_disk sotd 
		ON sotd.sotdoid = pg_class.oid 
	LEFT JOIN gp_toolkit.gp_size_of_table_and_indexes_disk sotaid 
		ON sotaid.sotaidoid = pg_class.oid 
	LEFT JOIN pg_namespace 
		ON pg_namespace.oid = pg_class.relnamespace 
WHERE 
	pg_class.relkind = 'r'
	AND relstorage != 'x' 						
	AND pg_namespace.nspname NOT IN ('information_schema', 'madlib', 'pg_catalog', 'gptext') 
	AND pg_class.relname NOT IN ('spatial_ref_sys') 
ORDER BY 1, 2
