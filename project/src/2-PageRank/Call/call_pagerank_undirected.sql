SELECT adj_lst();
\COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Code/SQL/2-PageRank/Test/test_2_0.txt WITH DELIMITER AS E'\t';
-- \COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Dataset/Archive/wiki-Vote.txt WITH DELIMITER AS E'\t';


SELECT node_lst();

SELECT undirected_proc();
SELECT out_degree();

SELECT adj_matrix_trans();
-- SELECT normalized_proc();

SELECT pr_rank();

SELECT pagerank(10, 0.85);
SELECT * FROM pr ORDER BY v_row;
\COPY pr TO /Users/runyunz/Documents/15826/Project/Code/SQL/2-PageRank/Test/test_2.res.txt WITH DELIMITER AS E'\t';
