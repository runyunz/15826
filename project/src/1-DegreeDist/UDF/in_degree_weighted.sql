DROP FUNCTION IF EXISTS in_degree_weighted();
CREATE OR REPLACE FUNCTION in_degree_weighted() RETURNS VOID AS --TABLE(node bigint, degree bigint) AS
$_$
BEGIN
	DROP TABLE IF EXISTS degree_weighted;
	CREATE TABLE IF NOT EXISTS degree_weighted(node bigint, degree bigint, weight double precision);
	INSERT INTO degree_weighted
		SELECT n_to AS node, count(n_from) AS degree, sum(weight) AS weight 
		FROM adj_lst_weighted GROUP BY n_to ORDER BY n_to;
	-- RETURN QUERY SELECT * FROM in_degree ORDER BY node;
END;
$_$	LANGUAGE plpgsql;
