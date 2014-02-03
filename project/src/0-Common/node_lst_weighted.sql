DROP FUNCTION IF EXISTS node_lst_weighted();
CREATE OR REPLACE FUNCTION node_lst_weighted() RETURNS VOID AS --TABLE(node bigint) AS
$_$
BEGIN	
	DROP TABLE IF EXISTS node_lst;
	CREATE TABLE IF NOT EXISTS node_lst(node bigint);

	INSERT INTO node_lst
		SELECT n_from AS node FROM adj_lst_weighted UNION DISTINCT SELECT n_to AS node FROM adj_lst_weighted ORDER BY node;
	-- RETURN QUERY SELECT * FROM node_lst ORDER BY node;

END;
$_$	LANGUAGE plpgsql;