CREATE OR REPLACE FUNCTION assign_matrix_column(matrix_name text, specific_column integer, specific_vector text)
RETURNS void AS
$_$
BEGIN
	EXECUTE
	'INSERT INTO '||matrix_name||'
	SELECT vector_row, '||specific_column||', vector_value
	FROM '||specific_vector||';';

END;
$_$	LANGUAGE plpgsql;
