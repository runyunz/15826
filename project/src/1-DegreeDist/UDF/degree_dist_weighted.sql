DROP FUNCTION IF EXISTS degree_dist_weighted();
CREATE OR REPLACE FUNCTION degree_dist_weighted() RETURNS VOID AS --TABLE(degree bigint, count bigint) AS
$_$
BEGIN
	DROP TABLE IF EXISTS degree_dist_weighted;
	CREATE TABLE IF NOT EXISTS degree_dist_weighted(weight double precision, count bigint); 
	INSERT INTO degree_dist_weighted
		SELECT degree_weighted.weight AS weight, count(*) AS count FROM degree_weighted 
		GROUP BY degree_weighted.weight ORDER BY degree_weighted.weight;

	DROP TABLE IF EXISTS degree_dist;
	CREATE TABLE IF NOT EXISTS degree_dist(degree bigint, count bigint); 
	INSERT INTO degree_dist
		SELECT degree_weighted.degree AS degree, count(*) AS count FROM degree_weighted  
		GROUP BY degree_weighted.degree ORDER BY degree_weighted.degree;
	-- RETURN QUERY SELECT * FROM degree_dist ORDER BY degree;
END;
$_$	LANGUAGE plpgsql;
