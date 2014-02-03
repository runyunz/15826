DROP FUNCTION IF EXISTS adj_matrix_trans();
CREATE OR REPLACE FUNCTION adj_matrix_trans() RETURNS VOID AS --TABLE(m_row bigint, m_col bigint, m_val double precision) AS
$_$
BEGIN	
	DROP TABLE IF EXISTS adj_matrix;
	CREATE TABLE IF NOT EXISTS adj_matrix(m_row bigint, m_col bigint, m_val double precision);
	-- INSERT INTO adj_matrix 
	-- 	SELECT n_to AS m_row, n_from AS m_col, 1 AS m_val FROM adj_lst;

	INSERT INTO adj_matrix 
		SELECT n_to AS m_row, n_from AS m_col, CAST(1 as double precision)/degree.degree AS m_val 
		FROM adj_lst, degree
		WHERE adj_lst.n_from = degree.node;
	-- RETURN QUERY SELECT * FROM adj_matrix ORDER BY m_row;
END;
$_$	LANGUAGE plpgsql;