SELECT adj_lst();
\COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Code/SQL/2-PageRank/Test/test_2_w.txt WITH DELIMITER AS E'\t';
-- \COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Dataset/Archive/wiki-Vote.txt WITH DELIMITER AS E'\t';

SELECT node_lst_weighted();

SELECT out_degree_weighted();

SELECT adj_matrix_trans_weighted();

SELECT pr_rank();

SELECT pagerank(100, 0.85);
SELECT * FROM pr ORDER BY v_row;
\COPY pr TO /Users/runyunz/Documents/15826/Project/Code/SQL/2-PageRank/Test/test_2_w.res.txt WITH DELIMITER AS E'\t';
