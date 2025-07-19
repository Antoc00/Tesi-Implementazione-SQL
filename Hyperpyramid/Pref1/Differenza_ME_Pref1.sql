CREATE OR REPLACE FUNCTION differenza_ME_hyp_pref1()
RETURNS TABLE(
  Attr1_diff varchar(150),
  Attr2_diff varchar(150),
  sd_diff triple[]) AS $$
BEGIN
RETURN QUERY
with t as (
  select t1_me_hyp_pref1.Attr1, t1_me_hyp_pref1.Attr2, array_difference_hyp(t1_me_hyp_pref1.sd,t2_me_hyp_pref1.sd) as sd_d
  from t1_me_hyp_pref1 join t2_me_hyp_pref1 on (t1_me_hyp_pref1.Attr1 = t2_me_hyp_pref1.Attr1 and t1_me_hyp_pref1.Attr2 = t2_me_hyp_pref1.Attr2)     
  where not (array_difference_hyp(t1_me_hyp_pref1.sd,t2_me_hyp_pref1.sd)  = '{}'))
select * from (
	select Attr1, Attr2, sd_d
	from t 
	union
	select Attr1, Attr2, sd
	from t1_me_hyp_pref1 where not exists (select * from t2_me_hyp_pref1 where t1_me_hyp_pref1.Attr1 = t2_me_hyp_pref1.Attr1 and t1_me_hyp_pref1.Attr2 = t2_me_hyp_pref1.Attr2));
END;
$$
LANGUAGE plpgsql;

SELECT * FROM differenza_ME_hyp_pref1();