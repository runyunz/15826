CREATE OR REPLACE FUNCTION create_matrix(matrix_name text)
RETURNS void AS
$_$
DECLARE
	exist boolean;
BEGIN
	EXECUTE
	'
	SELECT
	EXISTS (
	SELECT * 
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_NAME = '''||matrix_name||''')
        '
        INTO exist;
        
	
	IF exist = true
        THEN
		EXECUTE
		'TRUNCATE '||matrix_name||';';
        ELSE

	EXECUTE
	'CREATE TABLE '||matrix_name||'
	(
		matrix_row int,
		matrix_column int,
		matrix_value double precision
	);';
	END IF;
END;
$_$	LANGUAGE plpgsql;