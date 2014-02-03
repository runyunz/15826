CREATE OR REPLACE FUNCTION check_convergency(matrix_name text)
RETURNS boolean AS
$_$
DECLARE
	convergency boolean;
BEGIN
	EXECUTE
	'SELECT CASE
	WHEN EXISTS
	(
		SELECT *
		FROM '||matrix_name||'
		WHERE matrix_row != matrix_column
		AND @matrix_value > 0.01
		LIMIT 1
	)
	THEN 0
	ELSE 1
	END'
	INTO convergency;

	return convergency;
	
END;
$_$	LANGUAGE plpgsql;