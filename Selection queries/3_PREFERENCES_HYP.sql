CREATE OR REPLACE FUNCTION selezione_hyp_3()
RETURNS SETOF t1_hyp
AS $$
BEGIN
  RETURN QUERY
  SELECT c.*
  FROM t1_hyp c
  JOIN resource_constraints r
    ON c.s2 @> r.start
   AND c.e2 @> r.end
   AND c.d2 @> r.duration
   AND r.start + c.duration = c.end;
END;
$$ LANGUAGE plpgsql;

