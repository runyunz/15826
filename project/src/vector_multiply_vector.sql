CREATE OR REPLACE FUNCTION vector_multiply_vector(vector_name1 text, vector_name2 text)
RETURNS  double precision AS
$_$
DECLARE
	result double precision;
BEGIN
	DROP TABLE IF EXISTS temp_double;
	
	CREATE TABLE temp_double
	(
		var double precision
	);

	IF(vector_name1 = vector_name2)
	THEN
		EXECUTE
		'INSERT INTO temp_double
		SELECT SUM('||vector_name1||'.vector_value ^ 2)
		FROM '||vector_name1;
	ELSE
		EXECUTE
		'INSERT INTO temp_double
		SELECT SUM('||vector_name1||'.vector_value * '||vector_name2||'.vector_value)
		FROM '||vector_name1||', '||vector_name2||
		' WHERE '||vector_name1||'.vector_row = '||vector_name2||'.vector_row;';
	END IF;
	
	SELECT *
	INTO result
	FROM temp_double;

	return result;
END;
$_$	LANGUAGE plpgsql;