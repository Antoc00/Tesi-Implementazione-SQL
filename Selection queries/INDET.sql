CREATE OR REPLACE FUNCTION selezione_indet()
RETURNS SETOF t1
AS $$
BEGIN
  RETURN QUERY
	SELECT c.*
	FROM t1 c
	JOIN resource_constraints r
	WHERE
	  c.s @> r.start
	  AND c.d @> r.duration;
END;
$$ LANGUAGE plpgsql;

