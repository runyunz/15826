CREATE OR REPLACE FUNCTION generateUndirectedGraph()
RETURNS void AS
$$
BEGIN
IF(
	EXISTS(
		SELECT *
		FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = 'undirectedgraph'
		)
)
THEN DROP TABLE undirectedgraph;
END IF;

CREATE TABLE undirectedgraph
(
	sourceid	INT,
	destinationid	INT
);

INSERT INTO undirectedgraph
SELECT LEAST(sourceid,destinationid) id1, GREATEST(sourceid,destinationid) id2
FROM graph
WHERE sourceid != destinationid
ORDER BY id1, id2;

IF(
	EXISTS(
		SELECT *
		FROM INFORMATION_SCHEMA.SEQUENCES 
		WHERE SEQUENCE_NAME = 'seqid'
		)
)
THEN DROP SEQUENCE seqid;
END IF;

CREATE SEQUENCE seqid;

ALTER TABLE undirectedgraph
ADD COLUMN autoid INT
DEFAULT nextval('seqid');

DELETE FROM undirectedgraph
WHERE autoid NOT IN
(
	SELECT MIN(autoid)
	FROM undirectedgraph
	GROUP BY sourceid, destinationid
);

ALTER TABLE undirectedgraph
DROP COLUMN autoid;



END;
$$	LANGUAGE plpgsql