CREATE OR REPLACE FUNCTION matrix_multiply_vector(dst_vector_name text, matrix_name text, src_vector_name text)
RETURNS void AS
$_$
BEGIN
	IF(dst_vector_name = src_vector_name)
	THEN
		DROP TABLE IF EXISTS temp_vector_name;
		CREATE TABLE temp_vector_name
		(
			vector_row int,
			vector_value double precision
		);
		EXECUTE
		'INSERT INTO temp_vector_name
		SELECT *
		FROM '||src_vector_name||';';
		src_vector_name = 'temp_vector_name';
	END IF;
	
	EXECUTE
	'DROP TABLE IF EXISTS '||dst_vector_name||';';

	EXECUTE
	'CREATE TABLE '||dst_vector_name||'
	(
		vector_row int,
		vector_value double precision
	);';
	
	EXECUTE
	'INSERT INTO '||dst_vector_name||'
	SELECT matrix_row, SUM(my_value)
	FROM
	(
		SELECT matrix_row, matrix_value * vector_value AS my_value
		FROM '||matrix_name||', '||src_vector_name||'
		WHERE matrix_column = vector_row
	) AS my_matrix
	GROUP BY matrix_row;';

END;
$_$	LANGUAGE plpgsql;