CREATE OR REPLACE FUNCTION matrix_multiply_matrix(dst_matrix_name text, left_matrix_name text, right_matrix_name text)
RETURNS void AS
$_$
BEGIN
	IF(dst_matrix_name = left_matrix_name)
	THEN
		EXECUTE create_matrix('temp_matrix_name');
		EXECUTE
		'INSERT INTO temp_matrix_name
		SELECT *
		FROM '||left_matrix_name||';';
		left_matrix_name = 'temp_matrix_name';
	END IF;

	IF(dst_matrix_name = right_matrix_name)
	THEN
		
		EXECUTE create_matrix('temp_matrix_name');
		EXECUTE
		'INSERT INTO temp_matrix_name
		SELECT *
		FROM '||right_matrix_name||';';
		right_matrix_name = 'temp_matrix_name';
	END IF;

	EXECUTE create_matrix(dst_matrix_name);
	
	EXECUTE
	'INSERT INTO '||dst_matrix_name||'
	SELECT matrix_1.matrix_row, matrix_2.matrix_column,
		SUM(matrix_1.matrix_value * matrix_2.matrix_value)
	FROM '||left_matrix_name||' matrix_1, '||right_matrix_name||' matrix_2
	WHERE matrix_1.matrix_column = matrix_2.matrix_row
	GROUP BY matrix_1.matrix_row, matrix_2.matrix_column;';
END;
$_$	LANGUAGE plpgsql;