SELECT adj_lst();
-- \COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Code/SQL/2-PageRank/Test/test_2_s.txt WITH DELIMITER AS E'\t';
-- \COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Dataset/Archive/wiki-Vote.txt WITH DELIMITER AS E'\t';
\COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Dataset/TestCase/star.txt WITH DELIMITER AS E'\t';

SELECT node_lst();

-- SELECT undirected_proc();
SELECT out_degree();

SELECT adj_matrix_trans();
-- SELECT normalized_proc();

SELECT pr_rank();

SELECT pagerank(100, 0.85);
SELECT * FROM pr ORDER BY v_row;
\COPY pr TO /Users/runyunz/Documents/15826/Project/Code/SQL/2-PageRank/Test/test_2_s.res.txt WITH DELIMITER AS E'\t';
