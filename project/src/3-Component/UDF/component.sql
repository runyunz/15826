DROP FUNCTION IF EXISTS component(iter integer);
CREATE OR REPLACE FUNCTION component(iter integer) RETURNS VOID AS --RETURNS TABLE(node bigint, comp bigint) AS
$_$
DECLARE
	gcc_count integer=0;
	gcc_last integer=0;
BEGIN	
	DROP TABLE IF EXISTS conn_comp;
	DROP TABLE IF EXISTS comp_track;
	CREATE TABLE conn_comp AS (SELECT node_lst.node AS node, node_lst.node AS comp FROM node_lst);
	CREATE TABLE comp_track(round integer, gcc_count bigint);


	FOR i IN 1..iter LOOP
		UPDATE conn_comp
		SET comp = n1.comp FROM 
			(SELECT adj_lst.n_from AS node, MIN(conn_comp.comp) AS comp
			FROM adj_lst, conn_comp
			WHERE adj_lst.n_to = conn_comp.node
			GROUP BY adj_lst.n_from) n1
		WHERE conn_comp.node = n1.node;

		EXECUTE 'SELECT count(*) AS gcc_count FROM conn_comp GROUP BY comp ORDER BY gcc_count DESC LIMIT 1' INTO gcc_count;

		IF gcc_count = gcc_last THEN
			EXIT;
		END IF;

		EXECUTE 
		'INSERT INTO comp_track VALUES($1, $2)' USING i, gcc_count;

		gcc_last = gcc_count;

	END LOOP;
	-- RETURN QUERY SELECT * FROM conn_comp ORDER BY node;
END;
$_$	LANGUAGE plpgsql;