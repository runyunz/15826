CREATE OR REPLACE FUNCTION task5(a_matrix text, b text, m integer, k integer)
RETURNS void AS
$_$
DECLARE
	betai_1 double precision := 0;
	betai double precision;
	i integer;
	alphai double precision;
	epsilon double precision := 0.1;
	flag boolean := false;
	temp_number double precision;
BEGIN
	raise notice 'begin';
	EXECUTE 'select * from debug';
	EXECUTE create_b(b, a_matrix);
	EXECUTE create_vector('vi_1');
	EXECUTE create_matrix('v_matrix');
	EXECUTE create_vector('alpha');
	EXECUTE create_vector('beta');
	EXECUTE vector_scale('vi', b, 1/vector_length(b));
	FOR i IN 1..m LOOP
		raise notice 'main loop';
		EXECUTE assign_matrix_column('v_matrix', i, 'vi');
		EXECUTE matrix_multiply_vector('v', a_matrix, 'vi');
		alphai := vector_multiply_vector('vi', 'v');

		EXECUTE assign_vector_value('alpha', i, alphai);
		
		EXECUTE vector_scale('temp', 'vi_1', betai_1);
		EXECUTE vector_minus('v', 'v', 'temp');
		EXECUTE vector_scale('temp', 'vi', alphai);
		EXECUTE vector_minus('v', 'v', 'temp');
		betai := vector_length('v');
		
		EXECUTE create_tridiagonal_matrix('ti', 'alpha', 'beta');
		EXECUTE eig('q', 'd', 'ti');
		for j IN 1..i LOOP
			raise notice 'sub loop';
			if betai*abs(get_matrix_value('q', i, j)) <= epsilon*matrix_norm('ti')
			then
				raise notice 'here';
				EXECUTE get_matrix_column('qj', 'q', j);
				EXECUTE matrix_multiply_vector('r', 'v_matrix', 'qj');
				temp_number := vector_multiply_vector('r', 'v');
				EXECUTE vector_scale('r', 'r', temp_number);
				EXECUTE vector_minus('v', 'v', 'r');
				flag = true;
			end if;
		end loop;
		if flag = true
		then
			betai = vector_length('v');
			flag = false;
		end if;
		IF i != m
		THEN
			EXECUTE assign_vector_value('beta', i, betai);
		END IF;
		EXIT WHEN betai = 0;
		EXECUTE assign_vector('vi_1', 'vi');
		EXECUTE vector_scale('vi', 'v', 1/betai);
		betai_1 := betai;
	END LOOP;
	raise notice 'end loop';
	EXECUTE create_tridiagonal_matrix('tm', 'alpha', 'beta');
	EXECUTE eig('q', 'd', 'tm');
	EXECUTE eigenvalue('lambda', 'd', k);
	EXECUTE matrix_corp_column('qk', 'q', 1, k);
	EXECUTE matrix_multiply_matrix('rk', 'v_matrix', 'qk');
END;
$_$	LANGUAGE plpgsql;
