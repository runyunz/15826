-- find out in degree and out degree sparately
CREATE OR REPLACE FUNCTION task1()
RETURNS void AS
$_$

BEGIN
-- delete if temp table already exist.
IF(
	EXISTS(
		SELECT *
		FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = 'degreedistribution'
		)
)
THEN DROP TABLE degreedistribution;

END IF;

CREATE TABLE degreedistribution(
degree	int,
times	int
);

INSERT INTO degreedistribution
SELECT degree, COUNT(degree) AS times
FROM
(
	SELECT COUNT(sourceid) AS degree
	FROM
	(
		SELECT sourceid
		FROM undirectedgraph
		UNION ALL
		SELECT destinationid
		FROM undirectedgraph
	) AS bothid
	GROUP BY sourceid
	ORDER BY sourceid
) AS stat
GROUP BY degree
ORDER BY degree;

END;
$_$	LANGUAGE plpgsql;
