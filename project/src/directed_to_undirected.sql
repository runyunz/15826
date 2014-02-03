CREATE OR REPLACE FUNCTION directed_to_undirected(dst_matrix_name text, src_matrix_name text)
RETURNS void AS
$_$
BEGIN
	execute create_matrix(dst_matrix_name);
	
	execute
	'insert into '||dst_matrix_name||'
	select distinct least(source_id, destination_id) as least_column, greatest(source_id, destination_id) as greatest_column, 1
	from '||src_matrix_name||'
	ORDER BY least_column, greatest_column;';

	execute
	'insert into '||dst_matrix_name||'
	select matrix_column, matrix_row, 1
	from '||dst_matrix_name||'
	order by matrix_column, matrix_row;';

END;
$_$	LANGUAGE plpgsql;