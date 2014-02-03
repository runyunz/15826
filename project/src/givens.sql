-- to do: change b index --> -1

CREATE OR REPLACE FUNCTION givens(given_matrix_name text, matrix_r_name text, m integer, n integer)
RETURNS void AS
$_$
DECLARE
	c double precision;
	s double precision;
	a double precision;
	b double precision;
	t double precision;
	size integer;
BEGIN
	EXECUTE
	create_matrix(given_matrix_name);

	size := matrix_size(matrix_r_name);
	FOR i IN 1..size LOOP
		IF i != m AND i !=n
		THEN
			EXECUTE
			'INSERT INTO '||given_matrix_name||'
			VALUES('||i||', '||i||', 1);';
		END IF;
	END LOOP;

	a := get_matrix_value(matrix_r_name, m, m);
	b := get_matrix_value(matrix_r_name, n, m);
	t := sqrt(a^2+b^2);
	c = a/t;
	s = b/t;
	EXECUTE assign_matrix_value(given_matrix_name, m, m, c);
	EXECUTE assign_matrix_value(given_matrix_name, n, n, c);
	EXECUTE assign_matrix_value(given_matrix_name, m, n, s);
	EXECUTE assign_matrix_value(given_matrix_name, n, m, -s);
	
END;
$_$	LANGUAGE plpgsql;