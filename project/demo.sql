create table undirectedgraph(source_id integer, destination_id integer);
COPY undirectedgraph FROM './demo.txt' DELIMITER ',' CSV;
select * from task1();
select * from degreedistribution;
