SELECT adj_lst();
-- \COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Code/SQL/4-Radius/Test/test_4.txt WITH DELIMITER AS E'\t';
\COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Dataset/Archive/wiki-Vote.txt WITH DELIMITER AS E'\t';
-- \COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Dataset/Archive/adjnoun/out.adjnoun.adjnoun.res.txt WITH DELIMITER AS E'\t';

--SELECT * FROM adj_lst;

SELECT node_lst();
SELECT self_loop();
SELECT undirected_proc();

SELECT radius(256);
SELECT * FROM node_radius ORDER BY node;
SELECT radius, count(*) FROM node_radius GROUP BY radius ORDER BY radius;
\COPY node_radius TO /Users/runyunz/Documents/15826/Project/Code/SQL/4-Radius/Test/test_4.res.txt WITH DELIMITER AS E'\t';
