CREATE OR REPLACE FUNCTION selezione_hp_me(
  s integer,
  e integer,
  d integer,
  p text
)
RETURNS SETOF t1_me_hyp AS $$
BEGIN
  IF p NOT IN ('low', 'medium', 'high') THEN
    RAISE EXCEPTION 'Preferenza non valida: %, deve essere ''low'', ''medium'' o ''high''.', p;
  END IF;

  RETURN QUERY
  SELECT t1.*
  FROM t1_me_hyp AS t1,
       LATERAL unnest(
         CASE 
           WHEN p = 'low' THEN t1.low
           WHEN p = 'medium' THEN t1.medium
           WHEN p = 'high' THEN t1.high
         END
       ) AS t(s_un, e_un, d_un)
  WHERE t.s_un = s AND t.e_un = e AND t.d_un = d;
END;
$$ LANGUAGE plpgsql;