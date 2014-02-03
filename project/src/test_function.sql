CREATE OR REPLACE FUNCTION task2()
RETURNS void AS
$_$
DECLARE
	
BEGIN

IF(
	EXISTS(
		SELECT *
		FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = 'weighttable'
		)
)

THEN DROP TABLE weighttable;
END IF;

CREATE TABLE weighttable(
sid	int,
did	int,
weight	double precision
);

INSERT INTO weighttable
SELECT task2graph.sid, task2graph.did, newweighttable.weight
FROM task2graph
INNER JOIN
	(
	SELECT sid, COUNT(sid) weight
	FROM task2graph
	GROUP BY sid
	) AS newweighttable
ON task2graph.sid = newweighttable.sid;

UPDATE vector
SET vector2 = resultvector.result
FROM
	(
	SELECT weightvectortable.did, SUM(weightvectortable.vector1 / weightvectortable.weight) AS result
	FROM
		(
		SELECT weighttable.sid, weighttable.did,
			weighttable.weight, vector.vector1
		FROM weighttable
		INNER JOIN vector
		ON weighttable.sid = vector.id
		) AS weightvectortable
	GROUP BY did
	)as resultvector
WHERE vector.id = resultvector.did;
/*
IF(
	EXISTS(
		SELECT *
		FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = 'vector'
		)
)

THEN DROP TABLE vector;
END IF;
CREATE TABLE vector
(
	id int,
	vector1 double precision DEFAULT 0.5,
	vector2 double precision DEFAULT 0
);*/
END;
$_$	LANGUAGE plpgsql;