CREATE INDEX idx_gin_t3_sd ON t1_me_hyp_pref1 USING gin (sd);
CREATE INDEX idx_gin_t4_sd ON t2_me_hyp_pref1 USING gin (sd);

CREATE OR REPLACE FUNCTION prodotto_cartesiano_ME_hyp_Pref1()
RETURNS TABLE(
  Attr1_t1 varchar(150),
  Attr1_t2 varchar(150),
  Attr2_t1 varchar(150),
  Attr2_t2 varchar(150),
  sd triple[]
) AS $$
BEGIN
RETURN QUERY
SELECT t1_me_hyp_pref1.Attr1 AS Attr1_t1, t2_me_hyp_pref1.Attr1 AS Attr1_t2,
       t1_me_hyp_pref1.Attr2 AS Attr2_t1, t2_me_hyp_pref1.Attr2 AS Attr2_t2,
	   array_intersection_hyp(t1_me_hyp_pref1.sd, t2_me_hyp_pref1.sd) AS sd_pc
FROM t1_me_hyp_pref1, t2_me_hyp_pref1
WHERE NOT (array_intersection_hyp(t1_me_hyp_pref1.sd, t2_me_hyp_pref1.sd) = '{}');
END;
$$ LANGUAGE plpgsql;

select * from prodotto_cartesiano_ME_hyp_Pref1();
