DROP FUNCTION IF EXISTS degree_weighted();
CREATE OR REPLACE FUNCTION degree_weighted() RETURNS VOID AS --TABLE(node bigint, degree bigint) AS
$_$
BEGIN
	DROP TABLE IF EXISTS degree_weighted;
	CREATE TABLE IF NOT EXISTS degree_weighted(node bigint, degree bigint, weight double precision);
	INSERT INTO degree_weighted
		SELECT n_from AS node, count(n_to) AS degree, sum(weight) AS weight FROM adj_lst_weighted 
		GROUP BY n_from ORDER BY n_from;
	-- RETURN QUERY SELECT * FROM degree ORDER BY node;
END;
$_$	LANGUAGE plpgsql;
