DROP FUNCTION IF EXISTS degree_dist();
CREATE OR REPLACE FUNCTION degree_dist() RETURNS VOID AS --TABLE(degree bigint, count bigint) AS
$_$
BEGIN
	DROP TABLE IF EXISTS degree_dist;
	CREATE TABLE IF NOT EXISTS degree_dist(degree bigint, count bigint); 
	INSERT INTO degree_dist
		SELECT degree.degree AS degree, count(*) AS count FROM degree GROUP BY degree.degree ORDER BY degree.degree;
	-- RETURN QUERY SELECT * FROM degree_dist ORDER BY degree;
END;
$_$	LANGUAGE plpgsql;
