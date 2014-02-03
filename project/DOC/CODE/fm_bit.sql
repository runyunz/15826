CREATE OR REPLACE FUNCTION fm_bit(n integer) RETURNS SETOF bit_str AS
$_$
DECLARE
	res bit_str%rowtype;
	arr bigint[32];
BEGIN	
	FOR i IN 1..n LOOP
		FOR j IN 1..32 LOOP
			arr[j] := 2^floor(random()*32);
		END LOOP;
		res = row(i, arr);
		return next res;
	END LOOP;
	return;
END;
$_$	LANGUAGE plpgsql;