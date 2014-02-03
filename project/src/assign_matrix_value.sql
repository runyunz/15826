CREATE OR REPLACE FUNCTION assign_matrix_value(matrix_name text, row_number integer, column_number integer, assigned_value double precision)
RETURNS void AS
$_$
DECLARE
	result double precision;
BEGIN
	execute
	'insert into '||matrix_name||'
	values('||row_number||', '||column_number||', '||assigned_value||');';
END;
$_$	LANGUAGE plpgsql;