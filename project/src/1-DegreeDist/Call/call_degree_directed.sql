SELECT adj_lst();
\COPY adj_lst FROM /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_0.txt WITH DELIMITER AS E'\t';

SELECT in_degree();
SELECT degree_dist();
SELECT * FROM degree_dist;
\COPY degree_dist TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_in.txt WITH DELIMITER AS E'\t';

-- SELECT degree_dist_log();
-- SELECT * FROM degree_dist_log;
-- \COPY degree_dist_log TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_in.txt WITH DELIMITER AS E'\t';

SELECT out_degree();
SELECT degree_dist();
SELECT * FROM degree_dist;
\COPY degree_dist TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_out.txt WITH DELIMITER AS E'\t';

-- SELECT degree_dist_log();
-- SELECT * FROM degree_dist_log;
-- \COPY degree_dist_log TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_out.txt WITH DELIMITER AS E'\t';

