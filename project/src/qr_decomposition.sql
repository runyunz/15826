CREATE OR REPLACE FUNCTION qr_decomposition(matrix_q_name text, matrix_r_name text, matrix_a_name text)
RETURNS void AS
$_$
DECLARE
	m integer;
	i integer;
BEGIN

	m := matrix_size(matrix_a_name);
	EXECUTE create_identity_matrix(matrix_q_name, m);

	EXECUTE assign_matrix(matrix_r_name, matrix_a_name);
	FOR i IN 1..m-1 LOOP
		EXECUTE givens('temp_givens_matrix', matrix_r_name, i, i+1);
		EXECUTE matrix_multiply_matrix(matrix_q_name, 'temp_givens_matrix', matrix_q_name);
		EXECUTE matrix_multiply_matrix(matrix_r_name, 'temp_givens_matrix', matrix_r_name);
	END LOOP;
END;
$_$	LANGUAGE plpgsql;