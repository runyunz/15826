CREATE OR REPLACE FUNCTION create_tridiagonal_matrix(matrix_name text, vector_alpha_name text, vector_beta_name text)
RETURNS void AS
$_$
BEGIN
	EXECUTE create_matrix(matrix_name);
	
	EXECUTE
	'INSERT INTO '||matrix_name||'
	SELECT vector_row, vector_row, vector_value
	FROM '||vector_alpha_name||';';

	EXECUTE
	'INSERT INTO '||matrix_name||'
	SELECT vector_row, vector_row + 1, vector_value
	FROM '||vector_beta_name||';';

	EXECUTE
	'INSERT INTO '||matrix_name||'
	SELECT vector_row + 1, vector_row, vector_value
	FROM '||vector_beta_name||';';

END;
$_$	LANGUAGE plpgsql;