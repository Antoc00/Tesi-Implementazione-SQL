CREATE OR REPLACE FUNCTION array_difference(t1_me pair[], t2_me pair[]) RETURNS pair[] AS $$
BEGIN
    RETURN ARRAY(
        SELECT UNNEST(t1_me)
        EXCEPT
        SELECT UNNEST(t2_me)
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION differenza_ME()
RETURNS TABLE(
  Attr1_diff varchar(150),
  Attr2_diff varchar(150),
  low_diff pair[],
  medium_diff pair[],
  high_diff pair[]) AS $$
BEGIN
RETURN QUERY
with t as (
  select t1_me.Attr1, t1_me.Attr2, array_difference(t1_me.low,t2_me.low) as low_d, array_difference(t1_me.medium,t2_me.low) as medium_d, array_difference(t1_me.high,t2_me.low) as high_d
  from t1_me join t2_me on (t1_me.Attr1 = t2_me.Attr1 and t1_me.Attr2 = t2_me.Attr2)     
  where not (array_difference(t1_me.low,t2_me.low)  = '{}'))
select * from (
	select Attr1, Attr2, low_d, medium_d, high_d
	from t 
	union
	select Attr1, Attr2, low, medium, high
	from t1_me where not exists (select * from t2_me where t1_me.Attr1 = t2_me.Attr1 and t1_me.Attr2 = t2_me.Attr2));
END;
$$
LANGUAGE plpgsql;

SELECT * FROM differenza_ME();
