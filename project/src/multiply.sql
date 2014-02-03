-- calculate the weakly connected components.
-- For the algorithm see introductory paper 1.
-- Each connected components are labeled with
-- the smallest vertex index.
CREATE OR REPLACE FUNCTION mycopy(inputname text)
RETURNS TABLE(column1 int) AS
$_$

BEGIN

RETURN QUERY EXECUTE 'SELECT * FROM ' ||inputname|| ';';

END;
$_$	LANGUAGE plpgsql;