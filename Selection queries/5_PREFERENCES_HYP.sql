CREATE OR REPLACE FUNCTION selezione_hyp_5()
RETURNS SETOF t1_hyp
AS $$
BEGIN
  RETURN QUERY
  SELECT c.*
  FROM t1_hyp c
  JOIN resource_constraints r
    ON c.s3 @> r.start
   AND c.e3 @> r.end
   AND c.d3 @> r.duration
   AND r.start + c.duration = c.end;
END;
$$ LANGUAGE plpgsql;

