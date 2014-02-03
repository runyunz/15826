DROP FUNCTION IF EXISTS fake_belief_all();
CREATE OR REPLACE FUNCTION fake_belief_all() RETURNS VOID AS --TABLE(v_row bigint, v_col double precision) AS
$_$
DECLARE
	threshold double precision;
BEGIN
	INSERT INTO phi_vector 
		SELECT node as v_row, 0.01 as v_val FROM node_lst;
	-- RETURN QUERY SELECT * FROM phi_vector ORDER BY v_row;
END;
$_$	LANGUAGE plpgsql;