CREATE OR REPLACE FUNCTION assign_matrix(variable_name text, function_name text)
RETURNS text AS
$_$
BEGIN
	EXECUTE
	'DROP TABLE IF EXISTS '||variable_name||';';
	
	CREATE TABLE variable_name
	(
		var double precision
	);
	INSERT INTO variable_name
	SELECT * 
	FROM function_name;
	RETURN variable_name;
END;
$_$	LANGUAGE plpgsql;