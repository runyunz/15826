
CREATE OR REPLACE FUNCTION eig(matrix_q_name text, matrix_d_name text, matrix_tm_name text)
  RETURNS void AS
$BODY$
DECLARE
	k integer;
	m integer;
BEGIN
	--EXECUTE
	--'DROP TABLE IF EXISTS '||matrix_q_name||';';

	m := matrix_size(matrix_tm_name);
	EXECUTE create_identity_matrix(matrix_q_name, m);

	EXECUTE assign_matrix(matrix_d_name, matrix_tm_name);
	--FOR m IN 1..1 LOOP
	WHILE check_convergency(matrix_d_name) = false LOOP
		EXECUTE qr_decomposition('temp_q_matrix', 'temp_r_matrix', matrix_d_name);
		EXECUTE matrix_transpose('temp_q_matrix', 'temp_q_matrix');
		EXECUTE matrix_multiply_matrix(matrix_d_name, 'temp_r_matrix', 'temp_q_matrix');
		EXECUTE matrix_multiply_matrix(matrix_q_name, 'temp_q_matrix', matrix_q_name);
	END LOOP;


	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION eig(text, text, text)
  OWNER TO postgres;
