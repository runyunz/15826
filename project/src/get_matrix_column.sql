CREATE OR REPLACE FUNCTION get_matrix_column(vector_name text, matrix_name text, column_number integer)
RETURNS void AS
$_$
DECLARE

BEGIN
	EXECUTE create_vector(vector_name);

	EXECUTE
	'INSERT INTO '||vector_name||'
	SELECT matrix_row, matrix_value
	FROM '||matrix_name||'
	WHERE matrix_column = '||column_number||';';

END;
$_$	LANGUAGE plpgsql;