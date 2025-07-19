CREATE INDEX idx_t1_s1 ON t1_hyp USING GIST (s1);
CREATE INDEX idx_t2_s1 ON t2_hyp USING GIST (s1);
CREATE INDEX idx_t1_d1 ON t1_hyp USING GIST (d1);
CREATE INDEX idx_t2_d1 ON t2_hyp USING GIST (d1);

CREATE OR REPLACE FUNCTION hyper_prodotto_cartesiano_pref1()
RETURNS TABLE(
  Attr1_t1 varchar(150),
  Attr1_t2 varchar(150),
  Attr2_t1 varchar(150),
  Attr2_t2 varchar(150),
  s1 int4range,
  e1 int4range,
  d1 int4range ) AS $$
BEGIN
RETURN QUERY
SELECT 
  t1_hyp.Attr1, t2_hyp.Attr1, t1_hyp.Attr2, t2_hyp.Attr2,
  t1_hyp.s1 * t2_hyp.s1, t1_hyp.e1 * t2_hyp.e1,  t1_hyp.d1 * t2_hyp.d1

FROM 
  t1_hyp, t2_hyp 
WHERE 
  t1_hyp.s1 && t2_hyp.s1 AND 
  t1_hyp.e1 && t2_hyp.e1 AND
  t1_hyp.d1 && t2_hyp.d1;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM hyper_prodotto_cartesiano_pref1();
