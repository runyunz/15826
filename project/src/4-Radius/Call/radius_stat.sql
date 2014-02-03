DROP TABLE IF EXISTS res_stat;
\COPY node_radius FROM /Users/runyunz/Documents/15826/Project/Dataset/U_Youtube/Result/radius.txt WITH DELIMITER AS E'\t';

CREATE TABLE res_stat AS
	SELECT radius, count(*) FROM node_radius GROUP BY radius ORDER BY radius;

\COPY res_stat TO /Users/runyunz/Documents/15826/Project/Dataset/U_Youtube/Result/radius.stat.txt WITH DELIMITER AS E'\t';
