DROP FUNCTION IF EXISTS adj_lst();
CREATE OR REPLACE FUNCTION adj_lst() RETURNS VOID AS
$_$
BEGIN
	DROP TABLE IF EXISTS adj_lst;
	CREATE TABLE IF NOT EXISTS adj_lst(n_from bigint, n_to bigint);
	CREATE INDEX adf ON adj_lst(n_from);
	CREATE INDEX adt ON adj_lst(n_to);

END;
$_$	LANGUAGE plpgsql;