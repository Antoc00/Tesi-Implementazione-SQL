CREATE OR REPLACE FUNCTION selezione_hyp_10()
RETURNS SETOF t1_hyp
AS $$
BEGIN
  RETURN QUERY
  SELECT c.*
  FROM t1_hyp c
  JOIN resource_constraints r
    ON c.s5 @> r.start
   AND c.e5 @> r.end
   AND c.d5 @> r.duration
   AND r.start + c.duration = c.end;
END;
$$ LANGUAGE plpgsql;

