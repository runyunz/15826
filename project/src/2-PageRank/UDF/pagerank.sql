DROP FUNCTION IF EXISTS pagerank(iter integer, d double precision);
CREATE OR REPLACE FUNCTION pagerank(iter integer, d double precision) RETURNS VOID AS --TABLE(v_row bigint, v_val double precision) AS
$_$
DECLARE
	n bigint;
	y double precision;
BEGIN	
	DROP TABLE IF EXISTS pr;
	CREATE TABLE pr AS (SELECT * FROM pr_rank);

	EXECUTE 'SELECT count(*) FROM node_lst' INTO n;
	
	FOR i IN 1..iter LOOP
		EXECUTE 'SELECT SUM(v_val) * (1 - $1)/$2 FROM pr' INTO y USING d, n;
		EXECUTE
		'UPDATE pr
		SET v_val = $1 * p1.v_val + $2 FROM 
			(SELECT adj_matrix.m_row AS v_row, SUM(adj_matrix.m_val * pr.v_val) AS v_val
			FROM adj_matrix, pr
			WHERE adj_matrix.m_col = pr.v_row
			GROUP BY adj_matrix.m_row) p1
		WHERE pr.v_row = p1.v_row' USING d, y;

	END LOOP;

	-- RETURN QUERY SELECT * FROM pr ORDER BY v_row;
END;
$_$	LANGUAGE plpgsql;