CREATE OR REPLACE FUNCTION vector_scale(dst_vector_name text, src_vector_name text, scale double precision)
RETURNS void AS
$_$
BEGIN
	
	IF(dst_vector_name = src_vector_name)
	THEN
		DROP TABLE IF EXISTS temp_vector_name;
		CREATE TABLE temp_vector_name
		(
			vector_row int,
			vector_value double precision
		);
		EXECUTE
		'INSERT INTO temp_vector_name
		SELECT *
		FROM '||src_vector_name||';';
		src_vector_name = 'temp_vector_name';
	END IF;
	
	EXECUTE
	'DROP TABLE IF EXISTS '||dst_vector_name||';';

	EXECUTE
	'CREATE TABLE '||dst_vector_name||'
	(
		vector_row int,
		vector_value double precision
	);';
	
	EXECUTE
	'INSERT INTO '||dst_vector_name||'
	SELECT vector_row, vector_value * '||scale||
	' FROM ' ||src_vector_name||';';

END;
$_$	LANGUAGE plpgsql;