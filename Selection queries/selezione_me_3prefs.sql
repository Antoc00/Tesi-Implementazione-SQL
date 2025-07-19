CREATE OR REPLACE FUNCTION selezione_me(
  s integer,
  d integer,
  p text
)
RETURNS SETOF t2_me AS $$
BEGIN
  IF p NOT IN ('low', 'medium', 'high') THEN
    RAISE EXCEPTION 'Preferenza non valida: %, deve essere ''low'', ''medium'' o ''high''.', p;
  END IF;

  RETURN QUERY
  SELECT t2.*
  FROM t2_me AS t2,
       LATERAL unnest(
         CASE 
           WHEN p = 'low' THEN t2.low
           WHEN p = 'medium' THEN t2.medium
           WHEN p = 'high' THEN t2.high
         END
       ) AS val(s1, d1)
  WHERE val.s1 = s AND val.d1 = d;
END;
$$ LANGUAGE plpgsql;