CREATE OR REPLACE FUNCTION radius (iter integer) RETURNS TABLE(node integer, radius integer) AS
$_$
DECLARE
	round integer := 0;
	count integer := 0;
BEGIN	
	TRUNCATE bit_str;
	DROP TABLE IF EXISTS bit_str_check;
	DROP TABLE IF EXISTS node_radius;

	CREATE TABLE IF NOT EXISTS bit_str(node integer, str bigint[32]);
	INSERT INTO bit_str select * from fm_bit(8);
	CREATE TABLE bit_str_check AS SELECT node, str[1] FROM bit_str;
	CREATE TABLE IF NOT EXISTS node_radius(node integer, radius integer);
	
	FOR i IN 1..iter LOOP
		round := round +1;
		
		update bit_str
		set (str[1],str[2],str[3],str[4],str[5],str[6],str[7],str[8],str[9],str[10],str[11],str[12],str[13],str[14],str[15],str[16],
		str[17],str[18],str[19],str[20],str[21],str[22],str[23],str[24],str[25],str[26],str[27],str[28],str[29],str[30],str[31],str[32]) = 
		(str_new.str_n1, str_new.str_n2, str_new.str_n3, str_new.str_n4, str_new.str_n5, str_new.str_n6, str_new.str_n7, str_new.str_n8,
		str_new.str_n9, str_new.str_n10, str_new.str_n11, str_new.str_n12, str_new.str_n13, str_new.str_n14, str_new.str_n15, str_new.str_n16,
		str_new.str_n17, str_new.str_n18, str_new.str_n19, str_new.str_n20, str_new.str_n21, str_new.str_n22, str_new.str_n23, str_new.str_n24,
		str_new.str_n25, str_new.str_n26, str_new.str_n27, str_new.str_n28, str_new.str_n29, str_new.str_n30, str_new.str_n31, str_new.str_n32)
		from(
			select adj_lst.n_from as n_from, 
			bit_or(bit_str.str[1]) as str_n1, bit_or(bit_str.str[2]) as str_n2, bit_or(bit_str.str[3]) as str_n3, bit_or(bit_str.str[4]) as str_n4,
			bit_or(bit_str.str[5]) as str_n5, bit_or(bit_str.str[6]) as str_n6, bit_or(bit_str.str[7]) as str_n7, bit_or(bit_str.str[8]) as str_n8,
			bit_or(bit_str.str[9]) as str_n9, bit_or(bit_str.str[10]) as str_n10, bit_or(bit_str.str[11]) as str_n11, bit_or(bit_str.str[12]) as str_n12,
			bit_or(bit_str.str[13]) as str_n13, bit_or(bit_str.str[14]) as str_n14, bit_or(bit_str.str[15]) as str_n15, bit_or(bit_str.str[16]) as str_n16,
			bit_or(bit_str.str[17]) as str_n17, bit_or(bit_str.str[18]) as str_n18, bit_or(bit_str.str[19]) as str_n19, bit_or(bit_str.str[20]) as str_n20,
			bit_or(bit_str.str[21]) as str_n21, bit_or(bit_str.str[22]) as str_n22, bit_or(bit_str.str[23]) as str_n23, bit_or(bit_str.str[24]) as str_n24,
			bit_or(bit_str.str[25]) as str_n25, bit_or(bit_str.str[26]) as str_n26, bit_or(bit_str.str[27]) as str_n27, bit_or(bit_str.str[28]) as str_n28,
			bit_or(bit_str.str[29]) as str_n29, bit_or(bit_str.str[30]) as str_n30, bit_or(bit_str.str[31]) as str_n31, bit_or(bit_str.str[32]) as str_n32
			from adj_lst, bit_str
			where adj_lst.n_to = bit_str.node
			group by adj_lst.n_from) str_new
		where bit_str.node = str_new.n_from;

		EXECUTE 'INSERT INTO node_radius 
 			(SELECT bit_str_check.node, $1 FROM bit_str_check, bit_str 
 			WHERE bit_str_check.node=bit_str.node and bit_str_check.str=bit_str.str[1])' using round;

		DELETE FROM bit_str_check WHERE bit_str_check.node in 
 		(select bit_str_check.node from bit_str_check, bit_str 
 		where bit_str_check.node = bit_str.node and bit_str_check.str=bit_str.str[1]);

		SELECT COUNT(*) FROM bit_str_check into count;
		IF count = 0 THEN
			EXIT;
		END IF;

		UPDATE bit_str_check 
		SET str=bit_str.str[1] FROM bit_str
		WHERE bit_str_check.node=bit_str.node;
	END LOOP;
	return query select * from node_radius order by node;
END;
$_$	LANGUAGE plpgsql;