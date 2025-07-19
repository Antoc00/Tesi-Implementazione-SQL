CREATE OR REPLACE FUNCTION hyper_sub_n_m_pref5(
  t1_s1 int4range, t1_e1 int4range, t1_d1 int4range, 
  t1_s2 int4range, t1_e2 int4range, t1_d2 int4range, 
  t1_s3 int4range, t1_e3 int4range, t1_d3 int4range,
  t1_s4 int4range, t1_e4 int4range, t1_d4 int4range, 
  t1_s5 int4range, t1_e5 int4range, t1_d5 int4range,
  t2_s1 int4range, t2_e1 int4range, t2_d1 int4range, 
  t2_s2 int4range, t2_e2 int4range, t2_d2 int4range, 
  t2_s3 int4range, t2_e3 int4range, t2_d3 int4range,
  t2_s4 int4range, t2_e4 int4range, t2_d4 int4range, 
  t2_s5 int4range, t2_e5 int4range, t2_d5 int4range
)
RETURNS TABLE(
  s1 int4range, e1 int4range, d1 int4range,
  s2 int4range, e2 int4range, d2 int4range,
  s3 int4range, e3 int4range, d3 int4range,
  s4 int4range, e4 int4range, d4 int4range,
  s5 int4range, e5 int4range, d5 int4range
) AS $$
DECLARE
  ret1 int4range[];
  ret2 int4range[];
  ret3 int4range[];
  ret4 int4range[];
  ret5 int4range[];
BEGIN
  -- Caso in cui V2 sia vuoto oppure V1 e V2 non si intersecano
  IF isempty(t2_s1) AND isempty(t2_e1) AND isempty(t2_d1) AND isempty(t2_s2) AND isempty(t2_e2) AND isempty(t2_d2) AND 
     isempty(t2_s3) AND isempty(t2_e3) AND isempty(t2_d3) AND isempty(t2_s4) AND isempty(t2_e4) AND isempty(t2_d4) AND 
     isempty(t2_s5) AND isempty(t2_e5) AND isempty(t2_d5) OR 
     (NOT t1_s1 && t2_s1 OR NOT t1_d1 && t2_d1 OR NOT t1_e1 && t2_e1) THEN
    RETURN QUERY VALUES (
      t1_s1, t1_e1, t1_d1,
      t1_s2, t1_e2, t1_d2,
      t1_s3, t1_e3, t1_d3,
      t1_s4, t1_e4, t1_d4,
      t1_s5, t1_e5, t1_d5
    );
  ELSE
    -- Confronto con i livelli di V2
    ret1 = hyper_sub_1_m(t1_s1, t1_e1, t1_d1, t2_s1, t2_e1, t2_d1);
    ret2 = hyper_sub_1_m(t1_s2, t1_e2, t1_d2, t2_s1, t2_e1, t2_d1);
    ret3 = hyper_sub_1_m(t1_s3, t1_e3, t1_d3, t2_s1, t2_e1, t2_d1);
    ret4 = hyper_sub_1_m(t1_s4, t1_e4, t1_d4, t2_s1, t2_e1, t2_d1);
    ret5 = hyper_sub_1_m(t1_s5, t1_e5, t1_d5, t2_s1, t2_e1, t2_d1);

    -- Rimozione di start, duration o end quando uno è vuoto
    FOR i IN 1..15 LOOP
      IF isempty(ret1[i*3-2]) OR isempty(ret1[i*3-1]) OR isempty(ret1[i*3]) THEN
        ret1[i*3-2] = 'empty';
        ret1[i*3-1] = 'empty';
        ret1[i*3] = 'empty';
      END IF;
      IF isempty(ret2[i*3-2]) OR isempty(ret2[i*3-1]) OR isempty(ret2[i*3]) THEN
        ret2[i*3-2] = 'empty';
        ret2[i*3-1] = 'empty';
        ret2[i*3] = 'empty';
      END IF;
      IF isempty(ret3[i*3-2]) OR isempty(ret3[i*3-1]) OR isempty(ret3[i*3]) THEN
        ret3[i*3-2] = 'empty';
        ret3[i*3-1] = 'empty';
        ret3[i*3] = 'empty';
      END IF;
      IF isempty(ret4[i*3-2]) OR isempty(ret4[i*3-1]) OR isempty(ret4[i*3]) THEN
        ret4[i*3-2] = 'empty';
        ret4[i*3-1] = 'empty';
        ret4[i*3] = 'empty';
      END IF;
      IF isempty(ret5[i*3-2]) OR isempty(ret5[i*3-1]) OR isempty(ret5[i*3]) THEN
        ret5[i*3-2] = 'empty';
        ret5[i*3-1] = 'empty';
        ret5[i*3] = 'empty';
      END IF;
    END LOOP;

    -- Ritorno delle colonne risultanti
    RETURN QUERY VALUES (
      ret1[1], ret1[2], ret1[3],
      ret2[1], ret2[2], ret2[3],
      ret3[1], ret3[2], ret3[3],
      ret4[1], ret4[2], ret4[3],
      ret5[1], ret5[2], ret5[3]
    ),
    (ret1[4], ret1[5], ret1[6],
      ret2[4], ret2[5], ret2[6],
      ret3[4], ret3[5], ret3[6],
      ret4[4], ret4[5], ret4[6],
      ret5[4], ret5[5], ret5[6]),
         (ret1[7], ret1[8], ret1[9],
      ret2[7], ret2[8], ret2[9],
      ret3[7], ret3[8], ret3[9],
      ret4[7], ret4[8], ret4[9],
      ret5[7], ret5[8], ret5[9]),
   (ret1[10], ret1[11], ret1[6],
      ret2[10], ret2[11], ret2[12],
      ret3[10], ret3[11], ret3[12],
      ret4[10], ret4[11], ret4[12],
      ret5[10], ret5[11], ret5[12]),
         (ret1[13], ret1[5], ret1[6],
      ret2[13], ret2[14], ret2[15],
      ret3[13], ret3[14], ret3[15],
      ret4[13], ret4[14], ret4[15],
      ret5[13], ret5[14], ret5[15]),
         (ret1[16], ret1[17], ret1[18],
      ret2[16], ret2[17], ret2[18],
      ret3[16], ret3[17], ret3[18],
      ret4[16], ret4[17], ret4[18],
      ret5[16], ret5[17], ret5[18]);
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hyper_differenza_pref5()
RETURNS TABLE(
  Attr1_diff varchar(150),
  Attr2_diff varchar(150),
  s1_diff int4range, e1_diff int4range, d1_diff int4range,
  s2_diff int4range, e2_diff int4range, d2_diff int4range,
  s3_diff int4range, e3_diff int4range, d3_diff int4range,
  s4_diff int4range, e4_diff int4range, d4_diff int4range,
  s5_diff int4range, e5_diff int4range, d5_diff int4range
) AS $$
BEGIN
  RETURN QUERY
  WITH t AS (
    SELECT t1_hyp.Attr1, t1_hyp.Attr2, quadr.s1, quadr.e1, quadr.d1, quadr.s2, quadr.e2, quadr.d2,
           quadr.s3, quadr.e3, quadr.d3, quadr.s4, quadr.e4, quadr.d4, quadr.s5, quadr.e5, quadr.d5
    FROM t1_hyp
    JOIN t2_hyp ON (t1_hyp.Attr1 = t2_hyp.Attr1 AND t1_hyp.Attr2 = t2_hyp.Attr2)
    CROSS JOIN LATERAL hyper_sub_n_m_pref5(
      t1_hyp.s1, t1_hyp.e1, t1_hyp.d1,
      t1_hyp.s2, t1_hyp.e2, t1_hyp.d2,
      t1_hyp.s3, t1_hyp.e3, t1_hyp.d3,
      t1_hyp.s4, t1_hyp.e4, t1_hyp.d4,
      t1_hyp.s5, t1_hyp.e5, t1_hyp.d5,
      t2_hyp.s1, t2_hyp.e1, t2_hyp.d1,
      t2_hyp.s2, t2_hyp.e2, t2_hyp.d2,
      t2_hyp.s3, t2_hyp.e3, t2_hyp.d3,
      t2_hyp.s4, t2_hyp.e4, t2_hyp.d4,
      t2_hyp.s5, t2_hyp.e5, t2_hyp.d5
    ) AS quadr
    WHERE (NOT isempty(quadr.s1) AND NOT isempty(quadr.d1) AND NOT isempty(quadr.e1)) OR
          (NOT isempty(quadr.s2) AND NOT isempty(quadr.d2) AND NOT isempty(quadr.e2)) OR
          (NOT isempty(quadr.s3) AND NOT isempty(quadr.d3) AND NOT isempty(quadr.e3)) OR
          (NOT isempty(quadr.s4) AND NOT isempty(quadr.d4) AND NOT isempty(quadr.e4)) OR
          (NOT isempty(quadr.s5) AND NOT isempty(quadr.d5) AND NOT isempty(quadr.e5))
  )
  SELECT * FROM (
    SELECT Attr1, Attr2, s1, e1, d1, s2, e2, d2, s3, e3, d3, s4, e4, d4, s5, e5, d5 FROM t
    UNION
    SELECT Attr1, Attr2, s1, e1, d1, s2, e2, d2, s3, e3, d3, s4, e4, d4, s5, e5, d5
    FROM t1_hyp
    WHERE NOT EXISTS (
      SELECT * FROM t2_hyp WHERE t1_hyp.Attr1 = t2_hyp.Attr1 AND t1_hyp.Attr2 = t2_hyp.Attr2
    )
  );
END;
$$ LANGUAGE plpgsql;

