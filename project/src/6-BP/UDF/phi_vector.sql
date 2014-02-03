DROP FUNCTION IF EXISTS phi_vector();
CREATE OR REPLACE FUNCTION phi_vector() RETURNS VOID AS
$_$
BEGIN
	DROP TABLE IF EXISTS phi_vector;
	CREATE TABLE IF NOT EXISTS phi_vector(v_row integer, v_val double precision);
END;
$_$	LANGUAGE plpgsql;