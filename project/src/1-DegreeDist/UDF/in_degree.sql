DROP FUNCTION IF EXISTS in_degree();
CREATE OR REPLACE FUNCTION in_degree() RETURNS VOID AS --TABLE(node bigint, degree bigint) AS
$_$
BEGIN
	DROP TABLE IF EXISTS degree;
	CREATE TABLE IF NOT EXISTS degree(node bigint, degree bigint);
	INSERT INTO degree
		SELECT n_to AS node, count(n_from) AS degree FROM adj_lst GROUP BY n_to ORDER BY n_to;
	-- RETURN QUERY SELECT * FROM in_degree ORDER BY node;
END;
$_$	LANGUAGE plpgsql;
