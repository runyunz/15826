CREATE OR REPLACE FUNCTION pagerank(iter integer, d numeric) RETURNS TABLE(v_row integer, v_val numeric) AS
$_$
DECLARE
	n integer;
BEGIN	
	DROP TABLE IF EXISTS pr_matrix_d;
	DROP TABLE IF EXISTS pr;
	EXECUTE 'SELECT count(*) FROM pr_rank' into n;
	
	EXECUTE 'CREATE TABLE pr_matrix_d AS 
	(SELECT p1.v_row as m_row, p2.v_row as m_col, $1 as m_val FROM pr_rank as p1, pr_rank as p2)' using (1-d)/n;
	EXECUTE 'UPDATE pr_matrix_d set m_val = d1.m_val from
	(SELECT pr_matrix_d.m_row as m_row, pr_matrix_d.m_col as m_col, pr_matrix_d.m_val + $1 * pr_matrix.m_val as m_val
	from pr_matrix inner join pr_matrix_d using (m_row, m_col)) d1
	WHERE pr_matrix_d.m_row = d1.m_row and pr_matrix_d.m_col = d1.m_col' using d;
	
	CREATE TABLE pr AS (SELECT * FROM pr_rank);
	
	FOR i IN 1..iter LOOP
		UPDATE pr
		SET v_val = round(p1.v_val, 4) from
		(SELECT pr_matrix_d.m_row as v_row, sum(pr_matrix_d.m_val * pr.v_val) as v_val
		FROM pr_matrix_d, pr
		WHERE pr_matrix_d.m_col = pr.v_row
		GROUP by pr_matrix_d.m_row) p1
		WHERE pr.v_row = p1.v_row;		
	END LOOP;
	return query select * from pr order by v_row;
END;
$_$	LANGUAGE plpgsql;