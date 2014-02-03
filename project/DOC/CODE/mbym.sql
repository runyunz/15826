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
END;
$_$	LANGUAGE plpgsql;