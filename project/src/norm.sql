CREATE OR REPLACE FUNCTION matrix_norm(matrix_name text)
RETURNS double precision AS
$_$
DECLARE
	norm double precision;
BEGIN
	execute
	'select max(row_value)
	from
	(
		select |/SUM(matrix_value^2) as row_value
		from '||matrix_name||'
		group by matrix_row
	) as sum_vector'
	into norm;

	return norm;

END;
$_$	LANGUAGE plpgsql;