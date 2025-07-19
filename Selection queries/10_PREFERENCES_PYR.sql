CREATE OR REPLACE FUNCTION selezione_10()
RETURNS SETOF t1
AS $$
BEGIN
  RETURN QUERY
	SELECT c.*
	FROM t1 c
	JOIN resource_constraints r
	WHERE
	  c.s5 @> r.start
	  AND c.d5 @> r.duration;
END;
$$ LANGUAGE plpgsql;

