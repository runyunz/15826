DROP FUNCTION IF EXISTS bp(iter integer);
CREATE OR REPLACE FUNCTION bp(iter integer) RETURNS VOID AS --TABLE(v_row integer, v_val double precision) AS
$_$
DECLARE
	c1 double precision;
	c2 double precision;
	hh double precision;
	a double precision;
	c_prime double precision;
BEGIN	
	DROP TABLE IF EXISTS d_matrix;
	DROP TABLE IF EXISTS s_a;
	DROP TABLE IF EXISTS s_d;
	DROP TABLE IF EXISTS w_matrix;
	DROP TABLE IF EXISTS b_vector;
	DROP TABLE IF EXISTS belief;
	
	CREATE TABLE d_matrix AS
		SELECT m_row, m_row as m_col, SUM(m_val) as m_val from adj_matrix GROUP by m_row;
	
	EXECUTE 'SELECT SUM(m_val) + 2 from d_matrix' INTO c1; 
	EXECUTE 'SELECT SUM(m_val^2) - 1 from d_matrix' INTO c2; 
	
	hh = sqrt((-c1 + sqrt(c1 ^ 2 + 4 * c2)) / (8 * c2));
	a = 4 * (hh ^ 2) / (1 - 4 * (hh ^ 2));
	c_prime = 2 * hh / (1 - 4 * (hh ^ 2));

	EXECUTE 
	'CREATE TABLE w_matrix AS
		(SELECT m_row, m_col, $1 * m_val AS m_val FROM adj_matrix)
		UNION
		(SELECT m_row, m_col, $2 * m_val AS m_val FROM d_matrix)' USING a, (-c_prime);

	-- EXECUTE 'UPDATE adj_matrix SET m_val = $1 * m_val' USING a;
	-- EXECUTE 'INSERT INTO adj_matrix
	-- 	SELECT m_row, m_col, $1 * m_val AS m_val FROM d_matrix' USING (-c_prime);


	CREATE TABLE b_vector AS (SELECT * FROM phi_vector);
	CREATE TABLE belief AS (SELECT * FROM b_vector);
	
	FOR i IN 1..iter LOOP
		UPDATE b_vector
		SET v_val = b_new.v_val
		FROM(
			SELECT m_row AS v_row, 
			SUM(m_val * b_vector.v_val) AS v_val
			FROM w_matrix, b_vector
			-- FROM adj_matrix, b_vector
			WHERE m_col = b_vector.v_row
			GROUP BY m_row) b_new
		WHERE b_vector.v_row = b_new.v_row;

		UPDATE belief
		SET v_val = belief.v_val + b_vector.v_val FROM b_vector
		WHERE belief.v_row = b_vector.v_row;		
	END LOOP;
	-- RETURN QUERY SELECT * FROM belief ORDER BY v_row;
END;
$_$	LANGUAGE plpgsql;