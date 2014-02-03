DROP FUNCTION IF EXISTS radius(iter integer);
CREATE OR REPLACE FUNCTION radius(iter integer) RETURNS VOID AS --TABLE(node bigint, radius bigint) AS
$_$
DECLARE
	round integer = 0;
	count bigint;
	n bigint;
	arr bigint[32];
BEGIN	
	-- DROP VIEW IF EXISTS SS;
	DROP TABLE IF EXISTS bit_str;
	DROP TABLE IF EXISTS bit_str_check;
	DROP TABLE IF EXISTS node_radius;
	DROP TABLE IF EXISTS temp;

	EXECUTE 'SELECT COUNT(*) FROM node_lst' INTO n;

	CREATE TABLE IF NOT EXISTS bit_str(node bigint, str bigint[32]);
	FOR i IN 1..n LOOP
		FOR j IN 1..32 LOOP
			arr[j] := 2 ^ floor(random()*16);
		END LOOP;
		EXECUTE 'INSERT INTO bit_str VALUES($1, $2)' using CAST(i as bigint), arr;
	END LOOP;

	CREATE TABLE bit_str_check AS SELECT * FROM bit_str;
	CREATE TABLE IF NOT EXISTS node_radius(node bigint, radius bigint);
	CREATE TABLE IF NOT EXISTS temp(node bigint);

	FOR i IN 1..iter LOOP
		round := round + 1;
		
		UPDATE bit_str
		SET (str[1],str[2],str[3],str[4],str[5],str[6],str[7],str[8],str[9],str[10],str[11],str[12],str[13],str[14],str[15],str[16]) = 
		(str_new.str_n1, str_new.str_n2, str_new.str_n3, str_new.str_n4, str_new.str_n5, str_new.str_n6, str_new.str_n7, str_new.str_n8,
		str_new.str_n9, str_new.str_n10, str_new.str_n11, str_new.str_n12, str_new.str_n13, str_new.str_n14, str_new.str_n15, str_new.str_n16)
		FROM(
			SELECT adj_lst.n_from AS n_from, 
			bit_or(bit_str.str[1]) AS str_n1, bit_or(bit_str.str[2]) AS str_n2, bit_or(bit_str.str[3]) AS str_n3, bit_or(bit_str.str[4]) AS str_n4,
			bit_or(bit_str.str[5]) AS str_n5, bit_or(bit_str.str[6]) AS str_n6, bit_or(bit_str.str[7]) AS str_n7, bit_or(bit_str.str[8]) AS str_n8,
			bit_or(bit_str.str[9]) AS str_n9, bit_or(bit_str.str[10]) AS str_n10, bit_or(bit_str.str[11]) AS str_n11, bit_or(bit_str.str[12]) AS str_n12,
			bit_or(bit_str.str[13]) AS str_n13, bit_or(bit_str.str[14]) AS str_n14, bit_or(bit_str.str[15]) AS str_n15, bit_or(bit_str.str[16]) AS str_n16
			FROM adj_lst, bit_str
			WHERE adj_lst.n_to = bit_str.node
			GROUP BY adj_lst.n_from) str_new
		WHERE bit_str.node = str_new.n_from;

		
		TRUNCATE temp;
		INSERT INTO temp
			SELECT bit_str_check.node FROM bit_str_check, bit_str 
 			WHERE bit_str_check.node = bit_str.node AND bit_str_check.str=bit_str.str;

 		EXECUTE 'INSERT INTO node_radius (SELECT node, $1 FROM temp)' using round;


 		DELETE FROM bit_str_check WHERE node IN 
 		(SELECT node FROM temp);

		SELECT COUNT(*) FROM bit_str_check into count;
		IF count = 0 THEN
			EXIT;
		END IF;

		UPDATE bit_str_check 
		SET str=bit_str.str
		FROM bit_str
		WHERE bit_str_check.node = bit_str.node;
	END LOOP;
	-- RETURN QUERY SELECT * FROM node_radius ORDER BY node;
END;
$_$	LANGUAGE plpgsql;