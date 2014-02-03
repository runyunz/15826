SELECT adj_lst_weighted();
\COPY adj_lst_weighted FROM /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_w.txt WITH DELIMITER AS E'\t';

SELECT in_degree_weighted();
-- SELECT degree_dist();

SELECT degree_dist_weighted();
SELECT * FROM degree_weighted;
-- SELECT * FROM degree_dist;
-- SELECT * FROM degree_dist_weighted;
\COPY degree_weighted TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_in.txt WITH DELIMITER AS E'\t';
\COPY degree_dist TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_ind.txt WITH DELIMITER AS E'\t';
\COPY degree_dist_weighted TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_inw.txt WITH DELIMITER AS E'\t';


SELECT out_degree_weighted();
-- SELECT degree_dist();
SELECT degree_dist_weighted();
SELECT * FROM degree_weighted;
-- SELECT * FROM degree_dist;
-- SELECT * FROM degree_dist_weighted;
\COPY degree_weighted TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_out.txt WITH DELIMITER AS E'\t';
\COPY degree_dist TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_outd.txt WITH DELIMITER AS E'\t';
\COPY degree_dist_weighted TO /Users/runyunz/Documents/15826/Project/Code/SQL/1-DegreeDist/Test/test_1_res_outw.txt WITH DELIMITER AS E'\t';

