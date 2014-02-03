
CREATE OR REPLACE FUNCTION matrix_transpose(dst_matrix_name text, src_matrix_name text)
RETURNS void AS
$BODY$

BEGIN
	IF(dst_matrix_name = src_matrix_name)
	THEN
		EXECUTE create_matrix('temp_matrix_name');
		EXECUTE
		'INSERT INTO temp_matrix_name
		SELECT *
		FROM '||src_matrix_name||';';
		src_matrix_name = 'temp_matrix_name';
	END IF;
	
	EXECUTE create_matrix(dst_matrix_name);

	execute
	'INSERT INTO '||dst_matrix_name||'
	select matrix_column, matrix_row, matrix_value
	from '||src_matrix_name||';';
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION eig(text, text, text)
  OWNER TO postgres;
