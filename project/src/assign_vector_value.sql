CREATE OR REPLACE FUNCTION assign_vector_value(vector_name text, specific_row integer, specific_value double precision)
RETURNS void AS
$_$
BEGIN
	EXECUTE
	'INSERT INTO '||vector_name||'(vector_row, vector_value)
	VALUES('||specific_row||', '||specific_value||');';

END;
$_$	LANGUAGE plpgsql;
