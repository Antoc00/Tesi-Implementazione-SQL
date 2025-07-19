CREATE INDEX idx_gin_t3_lvl1 ON t1_me_hyp_pref5 USING gin (lvl1);
CREATE INDEX idx_gin_t4_lvl1 ON t2_me_hyp_pref5 USING gin (lvl1);

CREATE INDEX idx_gin_t3_lvl2 ON t1_me_hyp_pref5 USING gin (lvl2);
CREATE INDEX idx_gin_t4_lvl2 ON t2_me_hyp_pref5 USING gin (lvl2);

CREATE INDEX idx_gin_t3_lvl3 ON t1_me_hyp_pref5 USING gin (lvl3);
CREATE INDEX idx_gin_t4_lvl3 ON t2_me_hyp_pref5 USING gin (lvl3);

CREATE INDEX idx_gin_t3_lvl4 ON t1_me_hyp_pref5 USING gin (lvl4);
CREATE INDEX idx_gin_t4_lvl4 ON t2_me_hyp_pref5 USING gin (lvl4);

CREATE INDEX idx_gin_t3_lvl5 ON t1_me_hyp_pref5 USING gin (lvl5);
CREATE INDEX idx_gin_t4_lvl5 ON t2_me_hyp_pref5 USING gin (lvl5);

CREATE OR REPLACE FUNCTION prodotto_cartesiano_ME_hyp_Pref5()
RETURNS TABLE(
  Attr1_t1 varchar(150),
  Attr1_t2 varchar(150),
  Attr2_t1 varchar(150),
  Attr2_t2 varchar(150),
  lvl1 triple[],
  lvl2 triple[],
  lvl3 triple[],
  lvl4 triple[],
  lvl5 triple[]
) AS $$
BEGIN
RETURN QUERY
SELECT t1_me_hyp_pref5.Attr1 AS Attr1_t1, t2_me_hyp_pref5.Attr1 AS Attr1_t2,
       t1_me_hyp_pref5.Attr2 AS Attr2_t1, t2_me_hyp_pref5.Attr2 AS Attr2_t2,
	   array_intersection_hyp(t1_me_hyp_pref5.lvl1, t2_me_hyp_pref5.lvl1) AS lvl1_pc,
	   array_intersection_hyp(t1_me_hyp_pref5.lvl2, t2_me_hyp_pref5.lvl2) AS lvl2_pc,
	   array_intersection_hyp(t1_me_hyp_pref5.lvl3 , t2_me_hyp_pref5.lvl3) AS lvl3_pc,
     array_intersection_hyp(t1_me_hyp_pref5.lvl4 , t2_me_hyp_pref5.lvl4) AS lvl4_pc,
	   array_intersection_hyp(t1_me_hyp_pref5.lvl5 , t2_me_hyp_pref5.lvl5) AS lvl5_pc

FROM t1_me_hyp_pref5, t2_me_hyp_pref5
WHERE NOT (array_intersection_hyp(t1_me_hyp_pref5.lvl1, t2_me_hyp_pref5.lvl1) = '{}');
END;
$$ LANGUAGE plpgsql;


select * from prodotto_cartesiano_ME_hyp_Pref5();