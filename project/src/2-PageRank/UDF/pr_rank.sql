DROP FUNCTION IF EXISTS pr_rank();
CREATE OR REPLACE FUNCTION pr_rank() RETURNS VOID AS --TABLE(v_row bigint, v_col double precision) AS
$_$
DECLARE
	n double precision;
BEGIN
	DROP TABLE IF EXISTS pr_rank;
	CREATE TABLE IF NOT EXISTS pr_rank(v_row bigint, v_val double precision);

	EXECUTE 'SELECT CAST(1 AS double precision) / count(*) FROM node_lst' INTO n;
	EXECUTE
	'INSERT INTO pr_rank 
		SELECT node as v_row, $1 as v_val FROM node_lst' USING n;
	-- RETURN QUERY SELECT * FROM pr_rank ORDER BY v_row;
END;
$_$	LANGUAGE plpgsql;