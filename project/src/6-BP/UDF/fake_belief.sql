DROP FUNCTION IF EXISTS fake_belief();
CREATE OR REPLACE FUNCTION fake_belief() RETURNS VOID AS --TABLE(v_row bigint, v_col double precision) AS
$_$
DECLARE
	threshold double precision;
BEGIN
	EXECUTE 'SELECT AVG(node) FROM node_lst' INTO threshold;

	EXECUTE
	'INSERT INTO phi_vector 
		SELECT node as v_row, -0.01 as v_val FROM node_lst
		WHERE node < $1' USING threshold;

	EXECUTE
	'INSERT INTO phi_vector 
		SELECT node as v_row, 0.01 as v_val FROM node_lst
		WHERE node > $1' USING threshold;

	-- RETURN QUERY SELECT * FROM phi_vector ORDER BY v_row;
END;
$_$	LANGUAGE plpgsql;