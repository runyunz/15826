CREATE OR REPLACE FUNCTION vector_length(vector_name text)
RETURNS double precision AS
$_$
DECLARE
	length double precision;
BEGIN
	EXECUTE
	'
	SELECT |/SUM(vector_value^2)
	FROM '||vector_name||';'
	INTO length;

	return length;
END;
$_$	LANGUAGE plpgsql;