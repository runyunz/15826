DROP TABLE IF EXISTS adj_matrix;
DROP TABLE IF EXISTS phi_vector;

CREATE TABLE IF NOT EXISTS adj_matrix(m_row integer, m_col integer, m_val numeric);
\copy adj_matrix from /Users/runyunz/Documents/15826/Project/Code/adj_mat.txt with delimiter as ' ';
--SELECT * FROM adj_matrix;

CREATE TABLE IF NOT EXISTS phi_vector(v_row integer, v_val numeric);
\copy phi_vector from /Users/runyunz/Documents/15826/Project/Code/phi_vec.txt with delimiter as ' ';
--SELECT * FROM phi_vector;

SELECT * from bp(10);