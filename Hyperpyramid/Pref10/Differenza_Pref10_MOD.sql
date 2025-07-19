CREATE OR REPLACE FUNCTION hyper_sub_n_m_pref10(
  t1_s1 int4range, t1_e1 int4range, t1_d1 int4range, 
  t1_s2 int4range, t1_e2 int4range, t1_d2 int4range, 
  t1_s3 int4range, t1_e3 int4range, t1_d3 int4range,
  t1_s4 int4range, t1_e4 int4range, t1_d4 int4range, 
  t1_s5 int4range, t1_e5 int4range, t1_d5 int4range,
  t1_s6 int4range, t1_e6 int4range, t1_d6 int4range,
  t1_s7 int4range, t1_e7 int4range, t1_d7 int4range,
  t1_s8 int4range, t1_e8 int4range, t1_d8 int4range,
  t1_s9 int4range, t1_e9 int4range, t1_d9 int4range,
  t1_s10 int4range, t1_e10 int4range, t1_d10 int4range,
  t2_s1 int4range, t2_e1 int4range, t2_d1 int4range, 
  t2_s2 int4range, t2_e2 int4range, t2_d2 int4range, 
  t2_s3 int4range, t2_e3 int4range, t2_d3 int4range,
  t2_s4 int4range, t2_e4 int4range, t2_d4 int4range, 
  t2_s5 int4range, t2_e5 int4range, t2_d5 int4range,
  t2_s6 int4range, t2_e6 int4range, t2_d6 int4range,
  t2_s7 int4range, t2_e7 int4range, t2_d7 int4range,
  t2_s8 int4range, t2_e8 int4range, t2_d8 int4range,
  t2_s9 int4range, t2_e9 int4range, t2_d9 int4range,
  t2_s10 int4range, t2_e10 int4range, t2_d10 int4range
)
RETURNS TABLE(
  s1 int4range, e1 int4range, d1 int4range,
  s2 int4range, e2 int4range, d2 int4range,
  s3 int4range, e3 int4range, d3 int4range,
  s4 int4range, e4 int4range, d4 int4range,
  s5 int4range, e5 int4range, d5 int4range,
  s6 int4range, e6 int4range, d6 int4range,
  s7 int4range, e7 int4range, d7 int4range,
  s8 int4range, e8 int4range, d8 int4range,
  s9 int4range, e9 int4range, d9 int4range,
  s10 int4range, e10 int4range, d10 int4range
) AS $$
DECLARE
  ret1 int4range[];
  ret2 int4range[];
  ret3 int4range[];
  ret4 int4range[];
  ret5 int4range[];
  ret6 int4range[];
  ret7 int4range[];
  ret8 int4range[];
  ret9 int4range[];
  ret10 int4range[];
BEGIN
  -- Caso in cui V2 sia vuoto oppure V1 e V2 non si intersecano
  IF isempty(t2_s1) AND isempty(t2_e1) AND isempty(t2_d1) AND isempty(t2_s2) AND isempty(t2_e2) AND isempty(t2_d2) AND 
     isempty(t2_s3) AND isempty(t2_e3) AND isempty(t2_d3) AND isempty(t2_s4) AND isempty(t2_e4) AND isempty(t2_d4) AND 
     isempty(t2_s5) AND isempty(t2_e5) AND isempty(t2_d5) AND isempty(t2_s6) AND isempty(t2_e6) AND isempty(t2_d6) AND
     isempty(t2_s7) AND isempty(t2_e7) AND isempty(t2_d7) AND isempty(t2_s8) AND isempty(t2_e8) AND isempty(t2_d8) AND
     isempty(t2_s9) AND isempty(t2_e9) AND isempty(t2_d9) AND isempty(t2_s10) AND isempty(t2_e10) AND isempty(t2_d10) OR 
     (NOT t1_s1 && t2_s1 OR NOT t1_d1 && t2_d1 OR NOT t1_e1 && t2_e1) THEN
    RETURN QUERY VALUES (
      t1_s1, t1_e1, t1_d1,
      t1_s2, t1_e2, t1_d2,
      t1_s3, t1_e3, t1_d3,
      t1_s4, t1_e4, t1_d4,
      t1_s5, t1_e5, t1_d5,
      t1_s6, t1_e6, t1_d6,
      t1_s7, t1_e7, t1_d7,
      t1_s8, t1_e8, t1_d8,
      t1_s9, t1_e9, t1_d9,
      t1_s10, t1_e10, t1_d10
    );
  ELSE
    -- Confronto con i livelli di V2
    ret1 = hyper_sub_1_m(t1_s1, t1_e1, t1_d1, t2_s1, t2_e1, t2_d1);
    ret2 = hyper_sub_1_m(t1_s2, t1_e2, t1_d2, t2_s1, t2_e1, t2_d1);
    ret3 = hyper_sub_1_m(t1_s3, t1_e3, t1_d3, t2_s1, t2_e1, t2_d1);
    ret4 = hyper_sub_1_m(t1_s4, t1_e4, t1_d4, t2_s1, t2_e1, t2_d1);
    ret5 = hyper_sub_1_m(t1_s5, t1_e5, t1_d5, t2_s1, t2_e1, t2_d1);
    ret6 = hyper_sub_1_m(t1_s6, t1_e6, t1_d6, t2_s1, t2_e1, t2_d1);
    ret7 = hyper_sub_1_m(t1_s7, t1_e7, t1_d7, t2_s1, t2_e1, t2_d1);
    ret8 = hyper_sub_1_m(t1_s8, t1_e8, t1_d8, t2_s1, t2_e1, t2_d1);
    ret9 = hyper_sub_1_m(t1_s9, t1_e9, t1_d9, t2_s1, t2_e1, t2_d1);
    ret10 = hyper_sub_1_m(t1_s10, t1_e10, t1_d10, t2_s1, t2_e1, t2_d1);

    -- Rimozione di start, duration o end quando uno è vuoto
    FOR i IN 1..30 LOOP
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
      IF isempty(ret6[i*3-2]) OR isempty(ret6[i*3-1]) OR isempty(ret6[i*3]) THEN
        ret6[i*3-2] = 'empty';
        ret6[i*3-1] = 'empty';
        ret6[i*3] = 'empty';
      END IF;
      IF isempty(ret7[i*3-2]) OR isempty(ret7[i*3-1]) OR isempty(ret7[i*3]) THEN
        ret7[i*3-2] = 'empty';
        ret7[i*3-1] = 'empty';
        ret7[i*3] = 'empty';
      END IF;
      IF isempty(ret8[i*3-2]) OR isempty(ret8[i*3-1]) OR isempty(ret8[i*3]) THEN
        ret8[i*3-2] = 'empty';
        ret8[i*3-1] = 'empty';
        ret8[i*3] = 'empty';
      END IF;
      IF isempty(ret9[i*3-2]) OR isempty(ret9[i*3-1]) OR isempty(ret9[i*3]) THEN
        ret9[i*3-2] = 'empty';
        ret9[i*3-1] = 'empty';
        ret9[i*3] = 'empty';
      END IF;
      IF isempty(ret10[i*3-2]) OR isempty(ret10[i*3-1]) OR isempty(ret10[i*3]) THEN
        ret10[i*3-2] = 'empty';
        ret10[i*3-1] = 'empty';
        ret10[i*3] = 'empty';
      END IF;
    END LOOP;

    -- Ritorno delle colonne risultanti
RETURN QUERY VALUES
    (ret1[1], ret1[2], ret1[3], ret2[1], ret2[2], ret2[3], ret3[1], ret3[2], ret3[3], ret4[1], ret4[2], ret4[3], ret5[1], ret5[2], ret5[3], ret6[1], ret6[2], ret6[3], ret7[1], ret7[2], ret7[3], ret8[1], ret8[2], ret8[3], ret9[1], ret9[2], ret9[3], ret10[1], ret10[2], ret10[3]),
    (ret1[4], ret1[5], ret1[6], ret2[4], ret2[5], ret2[6], ret3[4], ret3[5], ret3[6], ret4[4], ret4[5], ret4[6], ret5[4], ret5[5], ret5[6], ret6[4], ret6[5], ret6[6], ret7[4], ret7[5], ret7[6], ret8[4], ret8[5], ret8[6], ret9[4], ret9[5], ret9[6], ret10[4], ret10[5], ret10[6]),
    (ret1[7], ret1[8], ret1[9], ret2[7], ret2[8], ret2[9], ret3[7], ret3[8], ret3[9], ret4[7], ret4[8], ret4[9], ret5[7], ret5[8], ret5[9], ret6[7], ret6[8], ret6[9], ret7[7], ret7[8], ret7[9], ret8[7], ret8[8], ret8[9], ret9[7], ret9[8], ret9[9], ret10[7], ret10[8], ret10[9]),
    (ret1[10], ret1[11], ret1[12], ret2[10], ret2[11], ret2[12], ret3[10], ret3[11], ret3[12], ret4[10], ret4[11], ret4[12], ret5[10], ret5[11], ret5[12], ret6[10], ret6[11], ret6[12], ret7[10], ret7[11], ret7[12], ret8[10], ret8[11], ret8[12], ret9[10], ret9[11], ret9[12], ret10[10], ret10[11], ret10[12]),
    (ret1[13], ret1[14], ret1[15], ret2[13], ret2[14], ret2[15], ret3[13], ret3[14], ret3[15], ret4[13], ret4[14], ret4[15], ret5[13], ret5[14], ret5[15], ret6[13], ret6[14], ret6[15], ret7[13], ret7[14], ret7[15], ret8[13], ret8[14], ret8[15], ret9[13], ret9[14], ret9[15], ret10[13], ret10[14], ret10[15]),
    (ret1[16], ret1[17], ret1[18], ret2[16], ret2[17], ret2[18], ret3[16], ret3[17], ret3[18], ret4[16], ret4[17], ret4[18], ret5[16], ret5[17], ret5[18], ret6[16], ret6[17], ret6[18], ret7[16], ret7[17], ret7[18], ret8[16], ret8[17], ret8[18], ret9[16], ret9[17], ret9[18], ret10[16], ret10[17], ret10[18]);
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hyper_differenza_pref10()
RETURNS TABLE(
  Attr1_diff varchar(150),
  Attr2_diff varchar(150),
  s1_diff int4range, e1_diff int4range, d1_diff int4range,
  s2_diff int4range, e2_diff int4range, d2_diff int4range,
  s3_diff int4range, e3_diff int4range, d3_diff int4range,
  s4_diff int4range, e4_diff int4range, d4_diff int4range,
  s5_diff int4range, e5_diff int4range, d5_diff int4range,
  s6_diff int4range, e6_diff int4range, d6_diff int4range,
  s7_diff int4range, e7_diff int4range, d7_diff int4range,
  s8_diff int4range, e8_diff int4range, d8_diff int4range,
  s9_diff int4range, e9_diff int4range, d9_diff int4range,
  s10_diff int4range, e10_diff int4range, d10_diff int4range
) AS $$
BEGIN
  RETURN QUERY
  WITH t AS (
    SELECT t1_hyp.Attr1, t1_hyp.Attr2, quadr.s1, quadr.e1, quadr.d1, quadr.s2, quadr.e2, quadr.d2,
           quadr.s3, quadr.e3, quadr.d3, quadr.s4, quadr.e4, quadr.d4, quadr.s5, quadr.e5, quadr.d5,
           quadr.s6, quadr.e6, quadr.d6, quadr.s7, quadr.e7, quadr.d7, quadr.s8, quadr.e8, quadr.d8,
           quadr.s9, quadr.e9, quadr.d9, quadr.s10, quadr.e10, quadr.d10
    FROM t1_hyp
    JOIN t2_hyp ON (t1_hyp.Attr1 = t2_hyp.Attr1 AND t1_hyp.Attr2 = t2_hyp.Attr2)
    CROSS JOIN LATERAL hyper_sub_n_m_pref10(
      t1_hyp.s1, t1_hyp.e1, t1_hyp.d1,
      t1_hyp.s2, t1_hyp.e2, t1_hyp.d2,
      t1_hyp.s3, t1_hyp.e3, t1_hyp.d3,
      t1_hyp.s4, t1_hyp.e4, t1_hyp.d4,
      t1_hyp.s5, t1_hyp.e5, t1_hyp.d5,
      t1_hyp.s6, t1_hyp.e6, t1_hyp.d6,
      t1_hyp.s7, t1_hyp.e7, t1_hyp.d7,
      t1_hyp.s8, t1_hyp.e8, t1_hyp.d8,
      t1_hyp.s9, t1_hyp.e9, t1_hyp.d9,
      t1_hyp.s10, t1_hyp.e10, t1_hyp.d10,
      t2_hyp.s1, t2_hyp.e1, t2_hyp.d1,
      t2_hyp.s2, t2_hyp.e2, t2_hyp.d2,
      t2_hyp.s3, t2_hyp.e3, t2_hyp.d3,
      t2_hyp.s4, t2_hyp.e4, t2_hyp.d4,
      t2_hyp.s5, t2_hyp.e5, t2_hyp.d5,
      t2_hyp.s6, t2_hyp.e6, t2_hyp.d6,
      t2_hyp.s7, t2_hyp.e7, t2_hyp.d7,
      t2_hyp.s8, t2_hyp.e8, t2_hyp.d8,
      t2_hyp.s9, t2_hyp.e9, t2_hyp.d9,
      t2_hyp.s10, t2_hyp.e10, t2_hyp.d10
    ) AS quadr
    WHERE (NOT isempty(quadr.s1) AND NOT isempty(quadr.d1) AND NOT isempty(quadr.e1)) OR
          (NOT isempty(quadr.s2) AND NOT isempty(quadr.d2) AND NOT isempty(quadr.e2)) OR
          (NOT isempty(quadr.s3) AND NOT isempty(quadr.d3) AND NOT isempty(quadr.e3)) OR
          (NOT isempty(quadr.s4) AND NOT isempty(quadr.d4) AND NOT isempty(quadr.e4)) OR
          (NOT isempty(quadr.s5) AND NOT isempty(quadr.d5) AND NOT isempty(quadr.e5)) OR
          (NOT isempty(quadr.s6) AND NOT isempty(quadr.d6) AND NOT isempty(quadr.e6)) OR
          (NOT isempty(quadr.s7) AND NOT isempty(quadr.d7) AND NOT isempty(quadr.e7)) OR
          (NOT isempty(quadr.s8) AND NOT isempty(quadr.d8) AND NOT isempty(quadr.e8)) OR
          (NOT isempty(quadr.s9) AND NOT isempty(quadr.d9) AND NOT isempty(quadr.e9)) OR
          (NOT isempty(quadr.s10) AND NOT isempty(quadr.d10) AND NOT isempty(quadr.e10))
  )
  SELECT * FROM (
    SELECT Attr1, Attr2, s1, e1, d1, s2, e2, d2, s3, e3, d3, s4, e4, d4, s5, e5, d5, s6, e6, d6, s7, e7, d7, s8, e8, d8, s9, e9, d9, s10, e10, d10
    FROM t
    UNION
    SELECT Attr1, Attr2, s1, e1, d1, s2, e2, d2, s3, e3, d3, s4, e4, d4, s5, e5, d5, s6, e6, d6, s7, e7, d7, s8, e8, d8, s9, e9, d9, s10, e10, d10
    FROM t1_hyp
    WHERE NOT EXISTS (
      SELECT * FROM t2_hyp WHERE t1_hyp.Attr1 = t2_hyp.Attr1 AND t1_hyp.Attr2 = t2_hyp.Attr2
    )
  );
END;
$$ LANGUAGE plpgsql;