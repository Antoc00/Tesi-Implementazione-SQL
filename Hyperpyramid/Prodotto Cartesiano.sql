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


CREATE OR REPLACE FUNCTION hyper_prodotto_cartesiano()
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
  d3 int4range ) AS $$
BEGIN
RETURN QUERY
SELECT 
  t1_hyp.Attr1, t2_hyp.Attr1, t1_hyp.Attr2, t2_hyp.Attr2,
  t1_hyp.s1 * t2_hyp.s1, t1_hyp.e1 * t2_hyp.e1,  t1_hyp.d1 * t2_hyp.d1,

  CASE 
      WHEN COALESCE(t1_hyp.e2 * t2_hyp.e2) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d2 * t2_hyp.d2) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s2 * t2_hyp.s2,'empty') END as s2,

  
  CASE 
      WHEN COALESCE(t1_hyp.s2 * t2_hyp.s2) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d2 * t2_hyp.d2) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e2 * t2_hyp.e2,'empty') END,
  
  CASE 
      WHEN COALESCE(t1_hyp.e2 * t2_hyp.e2) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s2 * t2_hyp.s2) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d2 * t2_hyp.d2,'empty') END,

  CASE 
      WHEN COALESCE(t1_hyp.e3 * t2_hyp.e3) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d3 * t2_hyp.d3) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
      ELSE COALESCE(t1_hyp.s3 * t2_hyp.s3,'empty') END as s3,
    
  CASE 
      WHEN COALESCE(t1_hyp.s3 * t2_hyp.s3) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.d3 * t2_hyp.d3) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.e3 * t2_hyp.e3,'empty') END,
  
  CASE 
      WHEN COALESCE(t1_hyp.e3 * t2_hyp.e3) IS NOT DISTINCT FROM 'empty' OR 
           COALESCE(t1_hyp.s3 * t2_hyp.s3) IS NOT DISTINCT FROM 'empty'
      THEN 'empty'
  ELSE COALESCE(t1_hyp.d3 * t2_hyp.d3,'empty') END

FROM 
  t1_hyp, t2_hyp 
WHERE 
  t1_hyp.s1 && t2_hyp.s1 AND 
  t1_hyp.e1 && t2_hyp.e1 AND
  t1_hyp.d1 && t2_hyp.d1;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM hyper_prodotto_cartesiano();
