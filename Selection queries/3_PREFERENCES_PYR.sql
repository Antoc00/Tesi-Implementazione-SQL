
  
CREATE OR REPLACE FUNCTION selezione_3()
RETURNS SETOF t1_im
AS $$
BEGIN
  RETURN QUERY
	SELECT c.*
	FROM t1_im c
	CROSS JOIN resource_constraints r
	WHERE
	  c.s2 @> r.start
	  AND c.d2 @> r.duration;
END;
$$ LANGUAGE plpgsql;

