CREATE OR REPLACE FUNCTION create_b(vector_name text, matrix_name text)
RETURNS void AS
$_$
DECLARE
	length integer;
	i integer;
BEGIN
	execute create_vector(vector_name);
	length := matrix_size(matrix_name);
	FOR i IN 1..length LOOP
		execute
		'insert into '||vector_name||'
		values('||i||', 1/sqrt('||length||'));';
	END LOOP;

END;
$_$	LANGUAGE plpgsql;