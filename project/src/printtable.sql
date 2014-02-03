CREATE OR REPLACE FUNCTION printtable(inputname text, outputname text)
RETURNS void AS

$_$

BEGIN

EXECUTE
'DROP TABLE IF EXISTS ' || outputname || ';';
EXECUTE
'CREATE TABLE ' || outputname ||
'(
	column1 integer
);';
EXECUTE
'INSERT INTO '|| outputname || 
' SELECT * FROM mycopy(''' || inputname ||''');';

END;
$_$	LANGUAGE plpgsql;