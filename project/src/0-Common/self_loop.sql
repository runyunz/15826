DROP FUNCTION IF EXISTS self_loop();
CREATE OR REPLACE FUNCTION self_loop() RETURNS VOID AS --TABLE(n_from bigint, n_to bigint) AS
$_$
BEGIN	
	INSERT INTO adj_lst 
		SELECT node as n_from, node as n_to FROM node_lst;
	-- RETURN QUERY SELECT * FROM adj_lst ORDER BY n_from;
END;
$_$	LANGUAGE plpgsql;