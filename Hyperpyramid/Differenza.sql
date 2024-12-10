-- Funzione che crea un int4range gestendo il caso empty
CREATE OR REPLACE FUNCTION safe_int4range(lower_bound integer, upper_bound integer, bounds TEXT) RETURNS int4range AS $$
  BEGIN
    IF lower_bound >= upper_bound THEN
      RETURN 'empty'::int4range;
    ELSE
      RETURN int4range(lower_bound, upper_bound, bounds);
    END IF;
  END; $$
 LANGUAGE plpgsql;

-- Funzione che calcola la differenza tra due strati della piramide
CREATE OR REPLACE FUNCTION hyperpyramid_diff(t1_s int4range, t1_e int4range, t1_d int4range, t2_s1 int4range, t2_e1 int4range, t2_d1 int4range)
RETURNS int4range[] AS $$
DECLARE ret int4range[];
BEGIN

ret = ARRAY[safe_int4range(lower(t1_s),greatest(lower(t1_s),lower(t2_s1)), '[)'),
	   safe_int4range(least(lower(t1_e), lower(t2_e1)),greatest(upper(t1_e),upper(t2_e1)),'[)'),
     safe_int4range(greatest(lower(t1_d),lower(t2_d1)), upper(t1_d),'[)'),
	  
     safe_int4range(greatest(lower(t1_s),lower(t2_s1)), upper(t1_s), '[)'),
	   safe_int4range(least(lower(t1_e), lower(t2_e1)),greatest(upper(t1_e),upper(t2_e1)),'[)'),
     safe_int4range(least(upper(t1_d),upper(t2_d1)), upper(t1_d),'[)'),
	   
     safe_int4range(least(upper(t1_s),upper(t2_s1)), upper(t1_s), '[)'),
	   safe_int4range(least(lower(t1_e), lower(t2_e1)),greatest(upper(t1_e),upper(t2_e1)),'[)'),
     safe_int4range(lower(t1_d), least(upper(t1_d),upper(t2_d1)),'[)'),
	   
	   safe_int4range(lower(t1_s),least(upper(t1_s),upper(t2_s1)), '[)'),
	   safe_int4range(least(lower(t1_e), lower(t2_e1)),greatest(upper(t1_e),upper(t2_e1)),'[)'),
     safe_int4range(lower(t1_d), greatest(lower(t1_d),lower(t2_d1)),'[)'),

	   safe_int4range(greatest(lower(t1_s),lower(t2_s1)),least(upper(t1_s),upper(t2_s1)), '[)'),
	   safe_int4range(least(lower(t1_e), lower(t2_e1)),least(upper(t1_e),upper(t2_e1)),'[)'),
     safe_int4range(greatest(lower(t1_d),lower(t2_d1)), least(lower(t1_d),lower(t2_d1)),'[)'),
     
     safe_int4range(greatest(lower(t1_s),lower(t2_s1)),least(upper(t1_s),upper(t2_s1)), '[)'),
	   safe_int4range(greatest(lower(t1_e), lower(t2_e1)),greatest(upper(t1_e),upper(t2_e1)),'[)'),
     safe_int4range(greatest(lower(t1_d),lower(t2_d1)), least(lower(t1_d),lower(t2_d1)),'[)')

     ];


RETURN ret;
END; $$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION hyper_sub_1_m(s1 int4range, e1 int4range, d1 int4range, t2_s1 int4range, t2_e1 int4range, t2_d1 int4range)
RETURNS int4range[] AS $$
DECLARE arr int4range[];
BEGIN
	arr = hyperpyramid_diff(s1, e1, d1 , t2_s1, t2_e1, t2_d1);
RETURN arr;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hyper_sub_n_m(t1_s1 int4range, t1_e1 int4range, t1_d1 int4range, t1_s2 int4range, t1_e2 int4range, t1_d2 int4range, t1_s3 int4range, t1_e3 int4range, t1_d3 int4range , t2_s1 int4range, t2_e1 int4range, t2_d1 int4range, t2_s2 int4range, t2_e2 int4range, t2_d2 int4range, t2_s3 int4range, t2_e3 int4range, t2_d3 int4range)
RETURNS TABLE(
  s1 int4range,
  e1 int4range,
  d1 int4range,
  s2 int4range,
  e2 int4range,
  d2 int4range,
  s3 int4range,
  e3 int4range,
  d3 int4range ) AS $$
DECLARE ret1 int4range[];
DECLARE ret2 int4range[];
DECLARE ret3 int4range[];
BEGIN
-- Caso in cui V2 sia vuoto oppure V1 e V2 non si intersecano
IF isempty(t2_s1) and isempty(t2_e1) and isempty(t2_d1) and isempty(t2_s2) and isempty(t2_e2) and isempty(t2_d2) and  isempty(t2_s3) and isempty(t2_e3) and isempty(t2_d3) 
   or (not t1_s1 && t2_s1 or not t1_d1 && t2_d1 or not t1_e1 && t2_e1) THEN
	RETURN QUERY VALUES (t1_s1, t1_e1, t1_d1, t1_s2, t1_e2, t1_d2, t1_s3, t1_e3, t1_d3);

-- Caso intersezione tra V1 e V2
ELSE 
-- Confronto con lo il primo strato di V2
		ret1 =  hyper_sub_1_m(t1_s1, t1_e1, t1_d1 , t2_s1, t2_e1, t2_d1);
		ret2 =  hyper_sub_1_m(t1_s2, t1_e2, t1_d2 , t2_s1, t2_e1, t2_d1);
		ret3 =  hyper_sub_1_m(t1_s3, t1_e3, t1_d3 , t2_s1, t2_e1,  t2_d1);

-- Rimozione di start o duration quando la corrispondente duration o start è empty
	FOR i in 1..6 LOOP
		IF isempty(ret1[i*3-1]) or isempty(ret1[i*3-2]) or isempty (ret1[i*3]) THEN
			ret1[i*3-1] = 'empty';
			ret1[i*3] = 'empty';
      ret1[i*3-2] = 'empty';
		END IF;

		IF isempty(ret2[i*3-1]) or isempty(ret2[i*3-2]) or isempty (ret2[i*3]) THEN
			ret2[i*3-1] = 'empty';
			ret2[i*3] = 'empty';
      ret2[i*3-2] = 'empty';
		END IF;

		IF isempty(ret3[i*3-1]) or isempty(ret3[i*3-2]) or isempty (ret3[i*3]) THEN
			ret3[i*3-1] = 'empty';
			ret3[i*3] = 'empty';
      ret3[i*3-2] = 'empty';
		END IF;	  
	END LOOP;

-- Ritorno delle colonne con le piramidi risultanti dalla differenza
	RETURN QUERY VALUES
    (ret1[1], ret1[2], ret1[3], ret2[1], ret2[2], ret2[3], ret3[1], ret3[2], ret3[3]),
    (ret1[4], ret1[5], ret1[6], ret2[4], ret2[5], ret2[6], ret3[4], ret3[5], ret3[6]),
    (ret1[7], ret1[8], ret1[9], ret2[7], ret2[8], ret2[9], ret3[7], ret3[8], ret3[9]),
    (ret1[10], ret1[11], ret1[12], ret2[10], ret2[11], ret2[12], ret3[10], ret3[11], ret3[12]),
    (ret1[13], ret1[14], ret1[15], ret2[13], ret2[14], ret2[15], ret3[13], ret3[14], ret3[15]),
    (ret1[16], ret1[17], ret1[18], ret2[16], ret2[17], ret2[18], ret3[16], ret3[17], ret3[18]);
END IF;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hyper_differenza()
RETURNS TABLE(
  Attr1_diff varchar(150),
  Attr2_diff varchar(150),
  s1_diff int4range,
  e1_diff int4range,
  d1_diff int4range,
  s2_diff int4range,
  e2_diff int4range,
  d2_diff int4range,
  s3_diff int4range,
  e3_diff int4range,
  d3_diff int4range ) AS $$
BEGIN
RETURN QUERY
with t as (
  select t1_hyp.Attr1, t1_hyp.Attr2, quadr.s1 , quadr.e1, quadr.d1, quadr.s2 , quadr.e2, quadr.d2 , quadr.s3, quadr.e3 , quadr.d3
  from t1_hyp join t2_hyp on (t1_hyp.Attr1 = t2_hyp.Attr1 and t1_hyp.Attr2 = t2_hyp.Attr2) CROSS JOIN LATERAL hyper_sub_n_m(t1_hyp.s1, t1_hyp.e1, t1_hyp.d1, t1_hyp.s2, t1_hyp.e2, t1_hyp.d2, t1_hyp.s3, t1_hyp.e3, t1_hyp.d3 , t2_hyp.s1, t2_hyp.e1, t2_hyp.d1, t2_hyp.s2, t2_hyp.e2, t2_hyp.d2, t2_hyp.s3, t2_hyp.e3, t2_hyp.d3)  as quadr
  where (not isempty(quadr.s1) AND not isempty(quadr.d1) AND not isempty(quadr.e1)) OR  (not isempty(quadr.s2) AND not isempty(quadr.d2) AND not isempty(quadr.e2)) OR (not isempty(quadr.s3) AND not isempty(quadr.d3) AND not isempty(quadr.e3)))
select * from (
	select Attr1, Attr2, s1, e1, d1, s2, e2, d2, s3, e3, d3 
	from t 
	union
	select Attr1, Attr2, s1 , e1, d1, s2 , e2, d2, s3 , e3, d3
	from t1_hyp where not exists (select * from t2_hyp where t1_hyp.Attr1 = t2_hyp.Attr1 and t1_hyp.Attr2 = t2_hyp.Attr2));
END;
$$
LANGUAGE plpgsql;

SELECT * FROM hyper_differenza();
