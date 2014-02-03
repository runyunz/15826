DROP FUNCTION IF EXISTS degree();
CREATE OR REPLACE FUNCTION degree() RETURNS VOID AS --TABLE(node bigint, degree bigint) AS
$_$
BEGIN
	DROP TABLE IF EXISTS degree;
	CREATE TABLE IF NOT EXISTS degree(node bigint, degree bigint);
	INSERT INTO degree
		SELECT n_from AS node, count(n_to) AS degree FROM adj_lst GROUP BY n_from ORDER BY n_from;
	-- RETURN QUERY SELECT * FROM degree ORDER BY node;
END;
$_$	LANGUAGE plpgsql;
