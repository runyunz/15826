CREATE OR REPLACE FUNCTION vector_minus(dst_vector_name text, vector_name1 text, vector_name2 text)
RETURNS void AS
$_$
BEGIN
	IF(vector_name1 = vector_name2)
	THEN
		EXECUTE
		'DROP TABLE IF EXISTS '||dst_vector_name||';';

		EXECUTE
		'CREATE TABLE '||dst_vector_name||'
		(
			vector_row int,
			vector_value double precision
		);';

		RETURN;
	END IF;
	
	IF(dst_vector_name = vector_name1)
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
		FROM '||vector_name1||';';
		vector_name1 = 'temp_vector_name';
	END IF;

	IF(dst_vector_name = vector_name2)
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
		FROM '||vector_name2||';';
		vector_name2 = 'temp_vector_name';
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
	SELECT vector_row, SUM(vector_value)
	FROM
	(
		SELECT *
		FROM '||vector_name1||'
		UNION ALL
		SELECT vector_row, -vector_value
		FROM  '||vector_name2||'
	) AS temp_vector
	GROUP BY vector_row;';

END;
$_$	LANGUAGE plpgsql;