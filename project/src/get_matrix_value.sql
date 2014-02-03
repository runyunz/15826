CREATE OR REPLACE FUNCTION get_matrix_value(matrix_name text, row_number integer, column_number integer)
RETURNS double precision AS
$_$
DECLARE
	result double precision;
BEGIN
	execute
	'select matrix_value
	from '||matrix_name||'
	where matrix_row = '||row_number||'
	and matrix_column = '||column_number||''
	into result;
	return result;
END;
$_$	LANGUAGE plpgsql;