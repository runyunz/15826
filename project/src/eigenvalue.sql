CREATE OR REPLACE FUNCTION eigenvalue(vector_lambda_name text, matrix_d_name text, top integer)
RETURNS void AS
$_$
BEGIN

	EXECUTE create_vector(vector_lambda_name);
	
	
	EXECUTE
	'INSERT INTO '||vector_lambda_name||'
	SELECT rank() OVER (ORDER BY matrix_value matrix_row), matrix_value
	FROM '||matrix_d_name||'
	where matrix_row = matrix_column
	LIMIT '||top||';';
END;
$_$	LANGUAGE plpgsql;