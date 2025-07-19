CREATE OR REPLACE FUNCTION selezione_me(
  s integer,
  d integer,
  livello integer
)
RETURNS SETOF t2_me AS $$
BEGIN
  IF livello NOT BETWEEN 1 AND 10 THEN
    RAISE EXCEPTION 'Livello non valido: %, deve essere compreso tra 1 e 10.', livello;
  END IF;

  RETURN QUERY
  SELECT t2.*
  FROM t2_me AS t2,
       LATERAL unnest(
         CASE livello
           WHEN 1 THEN t2.level1
           WHEN 2 THEN t2.level2
           WHEN 3 THEN t2.level3
           WHEN 4 THEN t2.level4
           WHEN 5 THEN t2.level5
           WHEN 6 THEN t2.level6
           WHEN 7 THEN t2.level7
           WHEN 8 THEN t2.level8
           WHEN 9 THEN t2.level9
           WHEN 10 THEN t2.level10
         END
       ) AS t(s, d)
  WHERE t.s = s AND t.d = d;
END;
$$ LANGUAGE plpgsql;