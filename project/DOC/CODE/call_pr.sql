DROP TABLE IF EXISTS pr_matrix;
DROP TABLE IF EXISTS pr_rank;

CREATE TABLE IF NOT EXISTS pr_matrix(m_row integer, m_col integer, m_val numeric);
\copy pr_matrix from /Users/runyunz/Documents/15826/Project/Code/pr_mat.txt with delimiter as ' ';
SELECT * FROM pr_matrix;

CREATE TABLE IF NOT EXISTS pr_rank(v_row integer, v_val numeric);
\copy pr_rank from /Users/runyunz/Documents/15826/Project/Code/pr_rank.txt with delimiter as ' ';
SELECT * FROM pr_rank;

SELECT * FROM pagerank(10, 0.85);