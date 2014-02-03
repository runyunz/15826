CREATE OR REPLACE FUNCTION run(k integer)
RETURNS void AS
$_$
BEGIN
	EXECUTE create_tridiagonal_matrix('tm', 'alpha', 'beta');
	EXECUTE eig('q', 'd', 'tm');
	EXECUTE eigenvalue('lambda', 'd', k);
	EXECUTE matrix_corp_column('qk', 'q', 1, k);
	--EXECUTE matrix_multiply_matrix('rk', 'v_matrix', 'qk');

END;
$_$	LANGUAGE plpgsql;