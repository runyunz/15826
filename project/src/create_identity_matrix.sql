-- to do: change b index --> -1

CREATE OR REPLACE FUNCTION create_identity_matrix(matrix_name text, matrix_order integer)
RETURNS void AS
$_$
DECLARE
	i integer;
BEGIN
	--EXECUTE
	--'DROP TABLE IF EXISTS '||matrix_name||';';

	EXECUTE create_matrix(matrix_name);

	FOR i IN 1..matrix_order LOOP
		execute
		'insert into '||matrix_name||'
		VALUES('||i||','||i||',1);';
	END LOOP;
	
END;
$_$	LANGUAGE plpgsql;