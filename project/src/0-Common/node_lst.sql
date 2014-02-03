DROP FUNCTION IF EXISTS node_lst();
CREATE OR REPLACE FUNCTION node_lst() RETURNS VOID AS --TABLE(node bigint) AS
$_$
BEGIN	
	DROP TABLE IF EXISTS node_lst;
	CREATE TABLE IF NOT EXISTS node_lst(node bigint);

	INSERT INTO node_lst
		SELECT n_from AS node FROM adj_lst UNION DISTINCT SELECT n_to AS node FROM adj_lst ORDER BY node;
	CREATE INDEX nd on node_lst(node);
	-- RETURN QUERY SELECT * FROM node_lst ORDER BY node;

END;
$_$	LANGUAGE plpgsql;