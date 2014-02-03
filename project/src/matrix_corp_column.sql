CREATE OR REPLACE FUNCTION matrix_corp_column(matrix_qk_name text, metrix_q_name text, column_low integer, column_high integer)
RETURNS void AS
$_$
BEGIN
	EXECUTE
	'DROP TABLE IF EXISTS '||matrix_qk_name||';';

	EXECUTE create_matrix(matrix_qk_name);
	
	
	EXECUTE
	'INSERT INTO '||matrix_qk_name||'
	SELECT *
	FROM '||metrix_q_name||'
	WHERE matrix_column >= '||column_low||'
	AND matrix_column <= '||column_high||';';
	
END;
$_$	LANGUAGE plpgsql;