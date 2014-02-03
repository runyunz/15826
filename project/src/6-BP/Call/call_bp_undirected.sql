SELECT adj_lst();
\COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Code/SQL/6-BP/Test/test_6.txt WITH DELIMITER AS E'\t';
-- \COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Dataset/Archive/wiki-Vote.txt WITH DELIMITER AS E'\t';


SELECT node_lst();
SELECT undirected_proc();
SELECT adj_matrix();
-- SELECT normalized_proc();
--SELECT * FROM adj_matrix;

SELECT phi_vector();
-- SELECT fake_belief();
-- SELECT fake_belief_all();

\COPY phi_vector FROM /Users/runyunz/Documents/15826/Project/Code/SQL/6-BP/Test/test_6.phi.txt WITH DELIMITER AS E'\t';
--SELECT * FROM phi_vector;

SELECT bp(50);
SELECT * FROM belief;
\COPY belief TO /Users/runyunz/Documents/15826/Project/Code/SQL/6-BP/Test/test_6.res.txt WITH DELIMITER AS E'\t';
