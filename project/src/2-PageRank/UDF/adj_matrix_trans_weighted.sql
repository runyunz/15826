DROP FUNCTION IF EXISTS adj_matrix_trans_weighted();
CREATE OR REPLACE FUNCTION adj_matrix_trans_weighted() RETURNS VOID AS --TABLE(m_row bigint, m_col bigint, m_val double precision) AS
$_$
BEGIN	
	DROP TABLE IF EXISTS adj_matrix;
	CREATE TABLE IF NOT EXISTS adj_matrix(m_row bigint, m_col bigint, m_val double precision);
	-- INSERT INTO adj_matrix 
	-- 	SELECT n_to AS m_row, n_from AS m_col, 1 AS m_val FROM adj_lst;

	INSERT INTO adj_matrix 
		SELECT n_to AS m_row, n_from AS m_col, adj_lst_weighted.weight/degree_weighted.weight AS m_val 
		FROM adj_lst_weighted, degree_weighted
		WHERE adj_lst_weighted.n_from = degree_weighted.node;
	-- RETURN QUERY SELECT * FROM adj_matrix ORDER BY m_row;
END;
$_$	LANGUAGE plpgsql;