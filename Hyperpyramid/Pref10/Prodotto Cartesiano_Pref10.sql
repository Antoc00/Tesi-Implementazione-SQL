CREATE INDEX idx_t1_s1 ON t1_hyp USING GIST (s1);
CREATE INDEX idx_t2_s1 ON t2_hyp USING GIST (s1);
CREATE INDEX idx_t1_d1 ON t1_hyp USING GIST (d1);
CREATE INDEX idx_t2_d1 ON t2_hyp USING GIST (d1);
CREATE INDEX idx_t1_s2 ON t1_hyp USING GIST (s2);
CREATE INDEX idx_t2_s2 ON t2_hyp USING GIST (s2);
CREATE INDEX idx_t1_d2 ON t1_hyp USING GIST (d2);
CREATE INDEX idx_t2_d2 ON t2_hyp USING GIST (d2);
CREATE INDEX idx_t1_s3 ON t1_hyp USING GIST (s3);
CREATE INDEX idx_t2_s3 ON t2_hyp USING GIST (s3);
CREATE INDEX idx_t1_d3 ON t1_hyp USING GIST (d3);
CREATE INDEX idx_t2_d3 ON t2_hyp USING GIST (d3);
CREATE INDEX idx_t1_e1 ON t1_hyp USING GIST (e1);
CREATE INDEX idx_t2_e1 ON t2_hyp USING GIST (e1);
CREATE INDEX idx_t1_e2 ON t1_hyp USING GIST (e2);
CREATE INDEX idx_t2_e2 ON t2_hyp USING GIST (e2);
CREATE INDEX idx_t1_e3 ON t1_hyp USING GIST (e3);
CREATE INDEX idx_t2_e3 ON t2_hyp USING GIST (e3);
CREATE INDEX idx_t1_s4 ON t1_hyp USING GIST (s4);
CREATE INDEX idx_t2_s4 ON t2_hyp USING GIST (s4);
CREATE INDEX idx_t1_d4 ON t1_hyp USING GIST (d4);
CREATE INDEX idx_t2_d4 ON t2_hyp USING GIST (d4);
CREATE INDEX idx_t1_e4 ON t1_hyp USING GIST (e4);
CREATE INDEX idx_t2_e4 ON t2_hyp USING GIST (e4);
CREATE INDEX idx_t1_s5 ON t1_hyp USING GIST (s5);
CREATE INDEX idx_t2_s5 ON t2_hyp USING GIST (s5);
CREATE INDEX idx_t1_d5 ON t1_hyp USING GIST (d5);
CREATE INDEX idx_t2_d5 ON t2_hyp USING GIST (d5);
CREATE INDEX idx_t1_e5 ON t1_hyp USING GIST (e5);
CREATE INDEX idx_t2_e5 ON t2_hyp USING GIST (e5);
CREATE INDEX idx_t1_s6 ON t1_hyp USING GIST (s6);
CREATE INDEX idx_t2_s6 ON t2_hyp USING GIST (s6);
CREATE INDEX idx_t1_d6 ON t1_hyp USING GIST (d6);
CREATE INDEX idx_t2_d6 ON t2_hyp USING GIST (d6);
CREATE INDEX idx_t1_e6 ON t1_hyp USING GIST (e6);
CREATE INDEX idx_t2_e6 ON t2_hyp USING GIST (e6);
CREATE INDEX idx_t1_s7 ON t1_hyp USING GIST (s7);
CREATE INDEX idx_t2_s7 ON t2_hyp USING GIST (s7);
CREATE INDEX idx_t1_d7 ON t1_hyp USING GIST (d7);
CREATE INDEX idx_t2_d7 ON t2_hyp USING GIST (d7);
CREATE INDEX idx_t1_e7 ON t1_hyp USING GIST (e7);
CREATE INDEX idx_t2_e7 ON t2_hyp USING GIST (e7);
CREATE INDEX idx_t1_s8 ON t1_hyp USING GIST (s8);
CREATE INDEX idx_t2_s8 ON t2_hyp USING GIST (s8);
CREATE INDEX idx_t1_d8 ON t1_hyp USING GIST (d8);
CREATE INDEX idx_t2_d8 ON t2_hyp USING GIST (d8);
CREATE INDEX idx_t1_e8 ON t1_hyp USING GIST (e8);
CREATE INDEX idx_t2_e8 ON t2_hyp USING GIST (e8);
CREATE INDEX idx_t1_s9 ON t1_hyp USING GIST (s9);
CREATE INDEX idx_t2_s9 ON t2_hyp USING GIST (s9);
CREATE INDEX idx_t1_d9 ON t1_hyp USING GIST (d9);
CREATE INDEX idx_t2_d9 ON t2_hyp USING GIST (d9);
CREATE INDEX idx_t1_e9 ON t1_hyp USING GIST (e9);
CREATE INDEX idx_t2_e9 ON t2_hyp USING GIST (e9);
CREATE INDEX idx_t1_s10 ON t1_hyp USING GIST (s10);
CREATE INDEX idx_t2_s10 ON t2_hyp USING GIST (s10);
CREATE INDEX idx_t1_d10 ON t1_hyp USING GIST (d10);
CREATE INDEX idx_t2_d10 ON t2_hyp USING GIST (d10);
CREATE INDEX idx_t1_e10 ON t1_hyp USING GIST (e10);
CREATE INDEX idx_t2_e10 ON t2_hyp USING GIST (e10);

CREATE OR REPLACE FUNCTION hyper_prodotto_cartesiano_pref10()
RETURNS TABLE(
  Attr1_t1 varchar(150),
  Attr1_t2 varchar(150),
  Attr2_t1 varchar(150),
  Attr2_t2 varchar(150),
  s1 int4range,
  e1 int4range,
  d1 int4range,
  s2 int4range,
  e2 int4range,
  d2 int4range,
  s3 int4range,
  e3 int4range,
  d3 int4range,
  s4 int4range,
  e4 int4range,
  d4 int4range,
  s5 int4range,
  e5 int4range,
  d5 int4range,
  s6 int4range,
  e6 int4range,
  d6 int4range,
  s7 int4range,
  e7 int4range,
  d7 int4range,
  s8 int4range,
  e8 int4range,
  d8 int4range,
  s9 int4range,
  e9 int4range,
  d9 int4range,
  s10 int4range,
  e10 int4range,
  d10 int4range
) AS $$
BEGIN
RETURN QUERY
SELECT 
  t1_hyp.Attr1, t2_hyp.Attr1, t1_hyp.Attr2, t2_hyp.Attr2,
  t1_hyp.s1 * t2_hyp.s1, t1_hyp.e1 * t2_hyp.e1,  t1_hyp.d1 * t2_hyp.d1,

  CASE 
      WHEN COALESCE(t1_hyp.e2 * t2_hyp.e2) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d2 * t2_hyp.d2) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s2 * t2_hyp.s2, 'empty') END as s2,

  CASE 
      WHEN COALESCE(t1_hyp.s2 * t2_hyp.s2) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d2 * t2_hyp.d2) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e2 * t2_hyp.e2, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e2 * t2_hyp.e2) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s2 * t2_hyp.s2) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d2 * t2_hyp.d2, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e3 * t2_hyp.e3) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d3 * t2_hyp.d3) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s3 * t2_hyp.s3, 'empty') END as s3,

  CASE 
      WHEN COALESCE(t1_hyp.s3 * t2_hyp.s3) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d3 * t2_hyp.d3) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e3 * t2_hyp.e3, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e3 * t2_hyp.e3) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s3 * t2_hyp.s3) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d3 * t2_hyp.d3, 'empty') END,

  -- Gestione per il livello 4
  CASE 
      WHEN COALESCE(t1_hyp.e4 * t2_hyp.e4) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d4 * t2_hyp.d4) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s4 * t2_hyp.s4, 'empty') END as s4,

  CASE 
      WHEN COALESCE(t1_hyp.s4 * t2_hyp.s4) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d4 * t2_hyp.d4) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e4 * t2_hyp.e4, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e4 * t2_hyp.e4) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s4 * t2_hyp.s4) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d4 * t2_hyp.d4, 'empty') END,

  -- Gestione per il livello 5
  CASE 
      WHEN COALESCE(t1_hyp.e5 * t2_hyp.e5) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d5 * t2_hyp.d5) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s5 * t2_hyp.s5, 'empty') END as s5,

  CASE 
      WHEN COALESCE(t1_hyp.s5 * t2_hyp.s5) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d5 * t2_hyp.d5) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e5 * t2_hyp.e5, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e5 * t2_hyp.e5) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s5 * t2_hyp.s5) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d5 * t2_hyp.d5, 'empty') END,

  -- Gestione per i livelli 6-10
  CASE 
      WHEN COALESCE(t1_hyp.e6 * t2_hyp.e6) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d6 * t2_hyp.d6) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s6 * t2_hyp.s6, 'empty') END as s6,

  CASE 
      WHEN COALESCE(t1_hyp.s6 * t2_hyp.s6) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d6 * t2_hyp.d6) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e6 * t2_hyp.e6, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e6 * t2_hyp.e6) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s6 * t2_hyp.s6) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d6 * t2_hyp.d6, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e7 * t2_hyp.e7) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d7 * t2_hyp.d7) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s7 * t2_hyp.s7, 'empty') END as s7,

  CASE 
      WHEN COALESCE(t1_hyp.s7 * t2_hyp.s7) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d7 * t2_hyp.d7) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e7 * t2_hyp.e7, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e7 * t2_hyp.e7) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s7 * t2_hyp.s7) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d7 * t2_hyp.d7, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e8 * t2_hyp.e8) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d8 * t2_hyp.d8) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s8 * t2_hyp.s8, 'empty') END as s8,

  CASE 
      WHEN COALESCE(t1_hyp.s8 * t2_hyp.s8) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d8 * t2_hyp.d8) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e8 * t2_hyp.e8, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e8 * t2_hyp.e8) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s8 * t2_hyp.s8) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d8 * t2_hyp.d8, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e9 * t2_hyp.e9) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d9 * t2_hyp.d9) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s9 * t2_hyp.s9, 'empty') END as s9,

  CASE 
      WHEN COALESCE(t1_hyp.s9 * t2_hyp.s9) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d9 * t2_hyp.d9) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e9 * t2_hyp.e9, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e9 * t2_hyp.e9) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s9 * t2_hyp.s9) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d9 * t2_hyp.d9, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e10 * t2_hyp.e10) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d10 * t2_hyp.d10) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s10 * t2_hyp.s10, 'empty') END as s10,

  CASE 
      WHEN COALESCE(t1_hyp.s10 * t2_hyp.s10) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d10 * t2_hyp.d10) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e10 * t2_hyp.e10, 'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e10 * t2_hyp.e10) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s10 * t2_hyp.s10) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d10 * t2_hyp.d10, 'empty') END

  FROM 
  t1_hyp, t2_hyp 
WHERE 
  t1_hyp.s1 && t2_hyp.s1 AND 
  t1_hyp.e1 && t2_hyp.e1 AND
  t1_hyp.d1 && t2_hyp.d1;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM hyper_prodotto_cartesiano_pref10();

