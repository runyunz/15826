CREATE OR REPLACE FUNCTION assign_matrix(dst_matrix_name text, src_matrix_name text)
RETURNS void AS
$_$
BEGIN
	EXECUTE create_matrix(dst_matrix_name);
	
	EXECUTE
	'INSERT INTO '||dst_matrix_name||'
	SELECT * FROM
	'||src_matrix_name||';';

END;
$_$	LANGUAGE plpgsql;