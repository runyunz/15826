SELECT adj_lst();
-- \COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Code/SQL/3-Component/Test/test_3.txt WITH DELIMITER AS E'\t';
-- \COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Dataset/Archive/wiki-Vote.txt WITH DELIMITER AS E'\t';
\COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Dataset/TestCase/combine.txt WITH DELIMITER AS E'\t';


SELECT node_lst();
SELECT self_loop();
SELECT undirected_proc();

SELECT component(20);
SELECT * FROM conn_comp;
SELECT * FROM comp_track;
\COPY conn_comp TO /Users/runyunz/Documents/15826/Project/Code/SQL/3-Component/Test/test_3_res.txt WITH DELIMITER AS E'\t';
