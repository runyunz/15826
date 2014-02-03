CREATE OR REPLACE FUNCTION task7(a_matrix text, b text, m integer, k integer)
RETURNS double precision AS
$_$
DECLARE
	triangle_number double precision;
BEGIN
	EXECUTE task5(a_matrix, b, m, k);
	select sum(vector_value^3)/6
	from lambda
	into triangle_number;
	return triangle_number;
END;
$_$	LANGUAGE plpgsql;