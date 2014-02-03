DROP FUNCTION IF EXISTS adj_lst_weighted();
CREATE OR REPLACE FUNCTION adj_lst_weighted() RETURNS VOID AS
$_$
BEGIN
	DROP TABLE IF EXISTS adj_lst_weighted;
	CREATE TABLE IF NOT EXISTS adj_lst_weighted(n_from bigint, n_to bigint, weight int);
END;
$_$	LANGUAGE plpgsql;