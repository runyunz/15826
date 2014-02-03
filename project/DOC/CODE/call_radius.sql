DROP TABLE IF EXISTS adj_lst;

CREATE TABLE IF NOT EXISTS adj_lst(n_from integer, n_to integer);
\copy adj_lst from /Users/runyunz/Documents/15826/Project/Code/adj_lst.txt with delimiter as ' ';
--SELECT * FROM adj_lst;

SELECT * FROM radius(10);