-- to do: change b index --> -1

CREATE OR REPLACE FUNCTION matrix_size(matrix_name text)
RETURNS integer AS
$_$
DECLARE
	m integer;
BEGIN
	EXECUTE
	'SELECT MAX(matrix_row)
	FROM
	(
		SELECT matrix_row
		FROM
		'||matrix_name||'
		UNION ALL
		SELECT matrix_column
		FROM
		'||matrix_name||'
	) AS temp_quiry'
	INTO m;
	
	return m;
	
END;
$_$	LANGUAGE plpgsql;