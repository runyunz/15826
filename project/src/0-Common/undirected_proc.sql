DROP FUNCTION IF EXISTS undirected_proc();
CREATE OR REPLACE FUNCTION undirected_proc() RETURNS VOID AS --TABLE(n_from bigint, n_to bigint) AS
$_$
BEGIN	
	DROP TABLE IF EXISTS undirected_proc;
	CREATE TABLE undirected_proc AS SELECT n_from, n_to FROM adj_lst UNION DISTINCT SELECT n_to, n_from FROM adj_lst;

	DROP TABLE adj_lst;
	ALTER TABLE undirected_proc RENAME TO adj_lst;
	CREATE INDEX adf on adj_lst(n_from);
	CREATE INDEX adt on adj_lst(n_to);
	-- RETURN QUERY SELECT * FROM adj_lst ORDER BY n_from;
END;
$_$	LANGUAGE plpgsql;