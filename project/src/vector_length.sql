CREATE OR REPLACE FUNCTION vector_length(vector_name text)
RETURNS double precision AS
$_$
DECLARE
	length double precision;
BEGIN
	DROP TABLE IF EXISTS temp_double;
	
	CREATE TABLE temp_double
	(
		var double precision
	);
	EXECUTE
	'INSERT INTO temp_double
	SELECT |/SUM(vector_value^2)
	FROM '||vector_name||';';
	
	SELECT *
	INTO length
	FROM temp_double;

	return length;
END;
$_$	LANGUAGE plpgsql;