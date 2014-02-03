DROP FUNCTION IF EXISTS radius(iter integer);
CREATE OR REPLACE FUNCTION radius(iter integer) RETURNS VOID AS --TABLE(node bigint, radius bigint) AS
$_$
DECLARE
	round integer = 0;
	count bigint;
	n bigint;
	arr bigint[32];
BEGIN	
	DROP TABLE IF EXISTS bit_str;
	DROP TABLE IF EXISTS bit_str_check;
	DROP TABLE IF EXISTS node_radius;
	DROP TABLE IF EXISTS temp;

	EXECUTE 'SELECT COUNT(*) FROM node_lst' INTO n;

	CREATE TABLE IF NOT EXISTS bit_str(node bigint, str bigint[32]);
	FOR i IN 1..n LOOP
		FOR j IN 1..32 LOOP
			arr[j] := 2 ^ floor(random()*32);
		END LOOP;
		EXECUTE 'INSERT INTO bit_str VALUES($1, $2)' using CAST(i as bigint), arr;
	END LOOP;

	CREATE TABLE bit_str_check AS SELECT * FROM bit_str;
	CREATE TABLE IF NOT EXISTS node_radius(node bigint, radius bigint);
	CREATE TABLE IF NOT EXISTS temp(node bigint);

	FOR i IN 1..iter LOOP
		round := round + 1;
		
		UPDATE bit_str
		SET (str[1],str[2],str[3],str[4],str[5],str[6],str[7],str[8],str[9],str[10],str[11],str[12],str[13],str[14],str[15],str[16],
		str[17],str[18],str[19],str[20],str[21],str[22],str[23],str[24],str[25],str[26],str[27],str[28],str[29],str[30],str[31],str[32]) = 
		(str_new.str_n1, str_new.str_n2, str_new.str_n3, str_new.str_n4, str_new.str_n5, str_new.str_n6, str_new.str_n7, str_new.str_n8,
		str_new.str_n9, str_new.str_n10, str_new.str_n11, str_new.str_n12, str_new.str_n13, str_new.str_n14, str_new.str_n15, str_new.str_n16,
		str_new.str_n17, str_new.str_n18, str_new.str_n19, str_new.str_n20, str_new.str_n21, str_new.str_n22, str_new.str_n23, str_new.str_n24,
		str_new.str_n25, str_new.str_n26, str_new.str_n27, str_new.str_n28, str_new.str_n29, str_new.str_n30, str_new.str_n31, str_new.str_n32)
		FROM(
			SELECT adj_lst.n_from AS n_from, 
			bit_or(bit_str.str[1]) AS str_n1, bit_or(bit_str.str[2]) AS str_n2, bit_or(bit_str.str[3]) AS str_n3, bit_or(bit_str.str[4]) AS str_n4,
			bit_or(bit_str.str[5]) AS str_n5, bit_or(bit_str.str[6]) AS str_n6, bit_or(bit_str.str[7]) AS str_n7, bit_or(bit_str.str[8]) AS str_n8,
			bit_or(bit_str.str[9]) AS str_n9, bit_or(bit_str.str[10]) AS str_n10, bit_or(bit_str.str[11]) AS str_n11, bit_or(bit_str.str[12]) AS str_n12,
			bit_or(bit_str.str[13]) AS str_n13, bit_or(bit_str.str[14]) AS str_n14, bit_or(bit_str.str[15]) AS str_n15, bit_or(bit_str.str[16]) AS str_n16,
			bit_or(bit_str.str[17]) AS str_n17, bit_or(bit_str.str[18]) AS str_n18, bit_or(bit_str.str[19]) AS str_n19, bit_or(bit_str.str[20]) AS str_n20,
			bit_or(bit_str.str[21]) AS str_n21, bit_or(bit_str.str[22]) AS str_n22, bit_or(bit_str.str[23]) AS str_n23, bit_or(bit_str.str[24]) AS str_n24,
			bit_or(bit_str.str[25]) AS str_n25, bit_or(bit_str.str[26]) AS str_n26, bit_or(bit_str.str[27]) AS str_n27, bit_or(bit_str.str[28]) AS str_n28,
			bit_or(bit_str.str[29]) AS str_n29, bit_or(bit_str.str[30]) AS str_n30, bit_or(bit_str.str[31]) AS str_n31, bit_or(bit_str.str[32]) AS str_n32
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