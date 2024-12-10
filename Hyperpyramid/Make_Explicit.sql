CREATE TYPE triple AS (
s int,
e int,
d int
);

CREATE OR REPLACE FUNCTION ExtHyp(s int4range, e int4range,d int4range)
RETURNS triple[] AS
$$
DECLARE result triple[];
BEGIN
  SELECT array_agg((s_val, e_val, d_val)::triple)
  INTO result
  FROM generate_series(lower(s), upper(s) - 1) AS s_val,
       generate_series(lower(e), upper(e) - 1) AS e_val,
       generate_series(lower(d), upper(d) - 1) AS d_val
  WHERE s_val + d_val = e_val;
  RETURN result;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION MakeExplicitHyp(
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
    d3 int4range
)
RETURNS TABLE(
    Attr1 varchar(150),
    Attr2 varchar(150),
    low triple[],
    medium triple[],
    high triple[]
) AS
$$
BEGIN
    RETURN QUERY SELECT Attributo1, Attributo2, ExtHyp(s1, e1, d1), ExtHyp(s2, e2, d2), ExtHyp(s3, e3, d3);
END
$$ LANGUAGE plpgsql;