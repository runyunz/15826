CREATE OR REPLACE FUNCTION create_vector(vector_name text)
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
        WHERE TABLE_NAME = '''||vector_name||''')
        '
        INTO exist;
        
	
	IF exist = true
        THEN
		EXECUTE
		'TRUNCATE '||vector_name||';';
        ELSE

	EXECUTE
	'CREATE TABLE '||vector_name||'
	(
		vector_row int,
		vector_value double precision
	);';
	END IF;
END;
$_$	LANGUAGE plpgsql;