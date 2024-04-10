CREATE OR REPLACE FUNCTION MakeExplicit_Pref1(
    Attributo1 varchar(150),
    Attributo2 varchar(150),
    s1 int4range,
    d1 int4range
)
RETURNS TABLE(
    Attr1 varchar(150),
    Attr2 varchar(150),
    sd pair[]
) AS
$$
BEGIN
    RETURN QUERY SELECT Attributo1, Attributo2, Ext(s1, d1);
END
$$ LANGUAGE plpgsql;