CREATE OR REPLACE FUNCTION bp (iter integer) RETURNS TABLE(v_row integer, v_val numeric) AS
$_$
DECLARE
	c1 numeric;
	c2 numeric;
	hh numeric;
	a numeric;
	c_prime numeric;
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
	hh := sqrt((-c1+sqrt(c1^2+4*c2))/(8*c2));
	a := 4*(hh^2)/(1-4*(hh^2));
	c_prime := 2*hh/(1-4*(hh^2));

	EXECUTE 'CREATE TABLE s_a AS SELECT m_row, m_col, $1*m_val as m_val from adj_matrix' USING a;
	EXECUTE 'CREATE TABLE s_d AS SELECT m_row, m_col, $1*m_val as m_val from d_matrix' USING (-c_prime);
	
	CREATE TABLE w_matrix AS
		SELECT * FROM s_a UNION SELECT * FROM s_d;

	CREATE TABLE b_vector AS (SELECT * FROM phi_vector);
	CREATE TABLE belief AS (SELECT * FROM b_vector);
	
	FOR i IN 1..iter LOOP
		UPDATE b_vector
		SET v_val = b_new.v_val
		FROM(
			SELECT m_row as v_row, 
			SUM(m_val * b_vector.v_val) as v_val
			FROM w_matrix, b_vector
			WHERE m_col = b_vector.v_row
			GROUP BY m_row) b_new
		WHERE b_vector.v_row = b_new.v_row;

		UPDATE belief
		SET v_val = round(belief.v_val + b_vector.v_val,2) FROM b_vector
		WHERE belief.v_row = b_vector.v_row;		
	END LOOP;
	return query select * from belief order by v_row;
END;
$_$	LANGUAGE plpgsql;