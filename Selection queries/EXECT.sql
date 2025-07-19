CREATE OR REPLACE FUNCTION selezione_exact()
RETURNS SETOF t1
AS $$
BEGIN
  RETURN QUERY
	SELECT c.*
	FROM t1 c
	JOIN resource_constraints r
	WHERE
	  c.s @> r.start
END;
$$ LANGUAGE plpgsql;

