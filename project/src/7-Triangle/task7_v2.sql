CREATE OR REPLACE FUNCTION task7(u text, lambda text)
RETURNS void AS
$_$
BEGIN
	execute create_vector('triangle_number');

	execute
	'insert into triangle_number
	select matrix_row, sum((matrix_value^2) * (vector_value^3))/2
	from '||u||', '||lambda||'
	where matrix_column = vector_row
	group by matrix_row;'; 
END;
$_$	LANGUAGE plpgsql;