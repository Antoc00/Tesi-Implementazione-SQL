CREATE OR REPLACE FUNCTION MakeExplicit_Pref5(
    Attributo1 varchar(150),
    Attributo2 varchar(150),
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
	  d5 int4range
)
RETURNS TABLE(
    Attr1 varchar(150),
    Attr2 varchar(150),
    lvl1 triple[],
    lvl2 triple[],
    lvl3 triple[],
	  lvl4 triple[],
	  lvl5 triple[]
) AS
$$
BEGIN
    RETURN QUERY SELECT Attributo1, Attributo2, Ext_hyp(s1, e1, d1), Ext_hyp(s2, e2, d2), Ext_hyp(s3,e3, d3), Ext_hyp(s4,e4, d4), Ext_hyp(s5,e5, d5);
END
$$ LANGUAGE plpgsql;