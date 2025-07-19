CREATE OR REPLACE FUNCTION MakeExplicit_Pref10(
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

)
RETURNS TABLE(
    Attr1 varchar(150),
    Attr2 varchar(150),
    lvl1 triple[],
    lvl2 triple[],
    lvl3 triple[],
	  lvl4 triple[],
	  lvl5 triple[],
    lvl6 triple[],
    lvl7 triple[],
    lvl8 triple[],
	  lvl9 triple[],
	  lvl10 triple[]
) AS
$$
BEGIN
    RETURN QUERY SELECT Attributo1, Attributo2, Ext(s1, e1, d1), Ext(s2,e2, d2), Ext(s3,e3, d3), Ext(s4,e4, d4), Ext(s5,e5, d5), Ext(s6,e6, d6), Ext(s7,e7, d7), Ext(s8, e8,d8), Ext(s9, e9,d9), Ext(s10,e10, d10);
END
$$ LANGUAGE plpgsql;