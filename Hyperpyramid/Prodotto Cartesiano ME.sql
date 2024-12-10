CREATE INDEX idx_gin_t3_low ON t1_me_hyp USING gin (low);
CREATE INDEX idx_gin_t4_low ON t2_me_hyp USING gin (low);

CREATE INDEX idx_gin_t3_me_medium ON t1_me_hyp USING gin (medium);
CREATE INDEX idx_gin_t4_me_medium ON t2_me_hyp USING gin (medium);

CREATE INDEX idx_gin_t3_high ON t1_me_hyp USING gin (high);
CREATE INDEX idx_gin_t4_high ON t2_me_hyp USING gin (high);

CREATE OR REPLACE FUNCTION array_intersection_hyp(t1_me_hyp triple[], t2_me_hyp triple[]) RETURNS triple[]
AS $$
BEGIN
    RETURN ARRAY(
        SELECT UNNEST(t1_me_hyp)
        INTERSECT
        SELECT UNNEST(t2_me_hyp)
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION prodotto_cartesiano_ME_hyp()
RETURNS TABLE(
  Attr1_t1 varchar(150),
  Attr1_t2 varchar(150),
  Attr2_t1 varchar(150),
  Attr2_t2 varchar(150),
  low triple[],
  medium triple[],
  high triple[]) AS $$
BEGIN
RETURN QUERY
SELECT t1_me_hyp.Attr1 AS Attr1_t1, t2_me_hyp.Attr1 AS Attr1_t2,
       t1_me_hyp.Attr2 AS Attr2_t1, t2_me_hyp.Attr2 AS Attr2_t2,
	   array_intersection_hyp(t1_me_hyp.low, t2_me_hyp.low) AS low_ps,
	   array_intersection_hyp(t1_me_hyp.medium, t2_me_hyp.medium) AS medium,
	   array_intersection_hyp(t1_me_hyp.high , t2_me_hyp.high) AS high
FROM t1_me_hyp, t2_me_hyp
WHERE NOT (array_intersection_hyp(t1_me_hyp.low, t2_me_hyp.low) = '{}');
END;
$$ LANGUAGE plpgsql;

SELECT * FROM prodotto_cartesiano_ME_hyp();

