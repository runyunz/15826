CREATE OR REPLACE FUNCTION component(iter integer) RETURNS TABLE(node integer, comp integer) AS
$_$
DECLARE
	res bit_str%rowtype;
	arr bigint[32];
BEGIN	
	DROP TABLE IF EXISTS conn_comp;
	CREATE TABLE conn_comp AS (SELECT distinct n_from AS node, n_from AS comp FROM adj_lst);

	FOR i IN 1..iter LOOP
		UPDATE conn_comp
		SET comp = n1.comp
		FROM (select n_from as node,  min(n_to) as comp from adj_lst group by n_from order by n_from) n1
		WHERE conn_comp.node = n1.node;
	END LOOP;
	return query select * from conn_comp order by node;
END;
$_$	LANGUAGE plpgsql;