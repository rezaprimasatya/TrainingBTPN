SELECT sotd.schemaname || '.' || sotd.tablename as tablename, 
	tabledisksize, 
	uncompressedsize, 
	tablesize, 
	indexsize, 
	toastsize, 
	othersize, 
	sopaid.partitionschemaname || '.' || sopaid.partitiontablename as partitionname, 
	sopaid.partitiontablesize, 
	sopaid.partitionindexsize 
FROM ( 
	SELECT sotd.sotdoid as oid, 
		sotd.sotdschemaname as schemaname, 
		sotd.sotdtablename as tablename, 
		pg_size_pretty(sotd.sotdsize::BIGINT) as tablesize, 
		pg_size_pretty(sotd.sotdtoastsize::BIGINT) as toastsize, 
		pg_size_pretty(sotd.sotdadditionalsize::BIGINT) as othersize 
	FROM 
		gp_toolkit.gp_size_of_table_disk as sotd 
	WHERE 
		sotd.sotdschemaname || '.' || sotd.sotdtablename = 'demo.amzn_reviews_partitioned') sotd 
	INNER JOIN ( 
		SELECT sotaid.sotaidoid as oid, 
			sotaid.sotaidschemaname as schemaname, 
			sotaid.sotaidtablename as tablename, 
			pg_size_pretty(sotaid.sotaidtablesize::BIGINT) as tabledisksize, 
			pg_size_pretty(sotaid.sotaididxsize::BIGINT) as indexsize 
		FROM 
			gp_toolkit.gp_size_of_table_and_indexes_disk as sotaid 
		WHERE 
			sotaid.sotaidschemaname || '.' || sotaid.sotaidtablename = 'demo.amzn_reviews_partitioned') sotaid 
	ON sotd.oid = sotaid.oid 
	INNER JOIN ( 
		SELECT sotu.sotuoid as oid, 
			sotu.sotuschemaname as schemaname, 
			sotu.sotutablename as tablename, 
			pg_size_pretty(sotu.sotusize::BIGINT) as uncompressedsize 
		FROM 
			gp_toolkit.gp_size_of_table_uncompressed as sotu 
		WHERE 
			sotu.sotuschemaname || '.' || sotu.sotutablename = 'demo.amzn_reviews_partitioned') sotu 
	ON sotaid.oid = sotu.oid 
	RIGHT OUTER JOIN ( 
		SELECT 
			sopaidparentoid as parenttableoid, 
			pg_size_pretty(sopaidpartitiontablesize::BIGINT) as partitiontablesize, 
			pg_size_pretty(sopaidpartitionindexessize::BIGINT) as partitionindexsize, 
			sopaidpartitionschemaname as partitionschemaname, 
			sopaidpartitiontablename as partitiontablename 
		FROM 
			gp_toolkit.gp_size_of_partition_and_indexes_disk 
		WHERE 
			sopaidparentschemaname || '.' || sopaidparenttablename = 'demo.amzn_reviews_partitioned') sopaid 
	ON sopaid.parenttableoid = sotd.oid;
