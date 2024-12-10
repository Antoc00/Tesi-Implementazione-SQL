CREATE OR REPLACE FUNCTION array_difference_hyp(t1_me_hyp triple[], t2_me_hyp triple[]) RETURNS triple[] AS $$
BEGIN
    RETURN ARRAY(
        SELECT UNNEST(t1_me_hyp)
        EXCEPT
        SELECT UNNEST(t2_me_hyp)
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION differenza_ME_hyp()
RETURNS TABLE(
  Attr1_diff varchar(150),
  Attr2_diff varchar(150),
  low_diff triple[],
  medium_diff triple[],
  high_diff triple[]) AS $$
BEGIN
RETURN QUERY
with t as (
  select t1_me_hyp.Attr1, t1_me_hyp.Attr2, array_difference_hyp(t1_me_hyp.low,t2_me_hyp.low) as low_d, array_difference_hyp(t1_me_hyp.medium,t2_me_hyp.low) as medium_d, array_difference_hyp(t1_me_hyp.high,t2_me_hyp.low) as high_d
  from t1_me_hyp join t2_me_hyp on (t1_me_hyp.Attr1 = t2_me_hyp.Attr1 and t1_me_hyp.Attr2 = t2_me_hyp.Attr2)     
  where not (array_difference_hyp(t1_me_hyp.low,t2_me_hyp.low)  = '{}'))
select * from (
	select Attr1, Attr2, low_d, medium_d, high_d
	from t 
	union
	select Attr1, Attr2, low, medium, high
	from t1_me_hyp where not exists (select * from t2_me_hyp where t1_me_hyp.Attr1 = t2_me_hyp.Attr1 and t1_me_hyp.Attr2 = t2_me_hyp.Attr2));
END;
$$
LANGUAGE plpgsql;

SELECT * FROM differenza_ME_hyp_Hyp();
