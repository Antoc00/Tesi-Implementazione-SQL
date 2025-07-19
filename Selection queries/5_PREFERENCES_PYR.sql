CREATE OR REPLACE FUNCTION selezione_5()
RETURNS SETOF t1
AS $$
BEGIN
  RETURN QUERY
	SELECT c.*
	FROM t1 c
	JOIN resource_constraints r
	WHERE
	  c.s3 @> r.start
	  AND c.d3 @> r.duration;
END;
$$ LANGUAGE plpgsql;

