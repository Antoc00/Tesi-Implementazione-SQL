CREATE OR REPLACE FUNCTION hyper_sub_n_m_pref1(t1_s1 int4range, t1_e1 int4range, t1_d1 int4range)
RETURNS TABLE(
  s1 int4range,
  e1 int4range,
  d1 int4range ) AS $$
DECLARE ret1 int4range[];
BEGIN
-- Caso in cui V2 sia vuoto oppure V1 e V2 non si intersecano
IF isempty(t2_s1) and isempty(t2_e1) and isempty(t2_d1) 
   or (not t1_s1 && t2_s1 or not t1_d1 && t2_d1 or not t1_e1 && t2_e1) THEN
	RETURN QUERY VALUES (t1_s1, t1_e1, t1_d1);

-- Caso intersezione tra V1 e V2
ELSE 
-- Confronto con lo il primo strato di V2
		ret1 =  hyper_sub_1_m(t1_s1, t1_e1, t1_d1 , t2_s1, t2_e1, t2_d1);
-- Rimozione di start o duration quando la corrispondente duration o start è empty
	FOR i in 1..6 LOOP
		IF isempty(ret1[i*3-1]) or isempty(ret1[i*3-2]) or isempty (ret1[i*3]) THEN
			ret1[i*3-1] = 'empty';
			ret1[i*3] = 'empty';
      ret1[i*3-2] = 'empty';
		END IF;
	END LOOP;

-- Ritorno delle colonne con le piramidi risultanti dalla differenza
	RETURN QUERY VALUES
    (ret1[1], ret1[2], ret1[3]),
    (ret1[4], ret1[5], ret1[6]),
    (ret1[7], ret1[8], ret1[9]),
    (ret1[10], ret1[11], ret1[12]),
    (ret1[13], ret1[14], ret1[15]),
    (ret1[16], ret1[17], ret1[18]);
END IF;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hyper_differenza_pref1()
RETURNS TABLE(
  Attr1_diff varchar(150),
  Attr2_diff varchar(150),
  s1_diff int4range,
  e1_diff int4range,
  d1_diff int4range ) AS $$
BEGIN
RETURN QUERY
with t as (
  select t1_hyp.Attr1, t1_hyp.Attr2, quadr.s1 , quadr.e1, quadr.d1
  from t1_hyp join t2_hyp on (t1_hyp.Attr1 = t2_hyp.Attr1 and t1_hyp.Attr2 = t2_hyp.Attr2) CROSS JOIN LATERAL hyper_sub_n_m_pref1(t1_hyp.s1, t1_hyp.e1, t1_hyp.d1 , t2_hyp.s1, t2_hyp.e1, t2_hyp.d1)  as quadr
  where (not isempty(quadr.s1) AND not isempty(quadr.d1) AND not isempty(quadr.e1)) )
select * from (
	select Attr1, Attr2, s1, e1, d1
	from t 
	union
	select Attr1, Attr2, s1 , e1, d1
	from t1_hyp where not exists (select * from t2_hyp where t1_hyp.Attr1 = t2_hyp.Attr1 and t1_hyp.Attr2 = t2_hyp.Attr2));
END;
$$
LANGUAGE plpgsql;

SELECT * FROM hyper_differenza_pref1();
