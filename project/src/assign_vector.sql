CREATE OR REPLACE FUNCTION assign_vector(vector_name text, function_name text)
RETURNS void AS
$_$
BEGIN
	EXECUTE
	'DROP TABLE IF EXISTS '||vector_name||';';

	EXECUTE
	'CREATE TABLE '||vector_name||'
	(
		vector_row int,
		vector_value double precision
	);';
	EXECUTE
	'INSERT INTO '||vector_name||'
	SELECT * FROM '
	||function_name||';';


END;
$_$	LANGUAGE plpgsql;