CREATE OR REPLACE FUNCTION RESET_pref1() RETURNS VOID AS $$
BEGIN

DROP TABLE IF EXISTS t1_hyp;
CREATE TABLE t1_hyp (
	Attr1 varchar(150),
	Attr2 varchar(150),
	s1 int4range,
  e1 int4range,
	d1 int4range
);

DROP TABLE IF EXISTS t2_hyp;
CREATE TABLE t2_hyp (
	Attr1 varchar(150),
	Attr2 varchar(150),
	s1 int4range,
  e1 int4range,
	d1 int4range
);

DROP TABLE IF EXISTS t1_me_hyp;
CREATE TABLE t1_me_hyp (
	Attr1 varchar(150),
	Attr2 varchar(150),
	low triple[]
	
);

DROP TABLE IF EXISTS t2_me_hyp;
CREATE TABLE t2_me_hyp (
	Attr1 varchar(150),
	Attr2 varchar(150),
	low triple[]
);


DROP TABLE IF EXISTS t5;
CREATE TABLE t5 (
	Attr1 varchar(150),
	Attr2 varchar(150),
	ID Serial
);

DROP TABLE IF EXISTS t6;
CREATE TABLE t6 (
	Attr1 varchar(150),
	Attr2 varchar(150),
	ID Serial
);
DROP TABLE IF EXISTS t7;
CREATE TABLE t7 (
	Attr1 varchar(150),
	Attr2 varchar(150),
  T int4range,
	ID Serial,
);

DROP TABLE IF EXISTS t8;
CREATE TABLE t8 (
	Attr1 varchar(150),
	Attr2 varchar(150),
  T int4range,
	ID Serial
);
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION random_text_md5_v2(INTEGER)
RETURNS TEXT
LANGUAGE SQL
AS $$ 
  select upper(
    substring(
      (SELECT string_agg(md5(random()::TEXT), '')
       FROM generate_series(
           1,
           CEIL($1 / 32.)::integer) 
       ), 1, $1) );
$$;
SELECT RESET_pref1();

CREATE OR REPLACE FUNCTION POPOLAMENTO_pref1(numrows decimal, nontempintersect decimal, tempintersect decimal, interval_mul decimal) 
RETURNS VOID AS $$
DECLARE r1 t1_hyp%rowtype;
DECLARE r2 t2_hyp%rowtype;
DECLARE start timestamp;
DECLARE countrows decimal;
DECLARE a integer;
DECLARE b integer;
DECLARE c integer;
DECLARE smin integer;
DECLARE smax integer;
DECLARE emin integer;
DECLARE emax integer;
DECLARE dmin integer;
DECLARE dmax integer;

BEGIN
set seed to 0.35;
start = clock_timestamp();
countrows = 0;
IF interval_mul <= 0 THEN
interval_mul = 1;
END IF;
	LOOP 
	EXIT WHEN countrows>=numrows;
		countrows = countrows+1;
		r1.Attr1 = random_text_md5_v2(25);
		r1.Attr2 = random_text_md5_v2(25);
		IF countrows < floor(numrows*nontempintersect) THEN
		r2.Attr1 = r1.Attr1;
		r2.Attr2 = r1.Attr2;
		ELSE 
		r2.Attr1 = random_text_md5_v2(25);
		r2.Attr2 = random_text_md5_v2(25);
		END IF;
		
-- DURATA QUADRUPLA 1 PRIMA TABELLA
a = 1 * interval_mul; b = 5 * interval_mul;
dmin = floor(random()*(b-a+1)) + a;
a = 6 * interval_mul; b = 10 * interval_mul;
dmax = floor(random()*(b-a+1)) + a;

r1.d1 = int4range(dmin, dmax, '[]');

-- DURATA QUADRUPLA 1 SECONDA TABELLA
a = 1 * interval_mul; b = 5 * interval_mul;                
dmin = floor(random()*(b-a+1)) + a;
a = 6 * interval_mul; b = 10 * interval_mul;
dmax = floor(random()*(b-a+1)) + a;

r2.d1 = int4range(dmin, dmax, '[]');

IF countrows < numrows * tempintersect THEN -- le quadruple si devono intersecare

    -- QUADRUPLA 1 PRIMA TABELLA
    a = 10 * interval_mul; b = 15 * interval_mul;          
    smin = floor(random()*(b-a+1)) + a; 
    a = 16 * interval_mul; b = 20 * interval_mul;          
    smax = floor(random()*(b-a+1)) + a;

    r1.s1 = int4range(smin, smax, '[]');		
    
    -- END QUADRUPLA 1 PRIMA TABELLA
    a = smin + 5 * interval_mul; b = smin + 10 * interval_mul;
    emin = floor(random()*(b-a+1)) + a;
    a = smax + 11 * interval_mul; b = smax + 15 * interval_mul;
    emax = floor(random()*(b-a+1)) + a;

    r1.e1 = int4range(emin, emax, '[]');

    -- QUADRUPLA 1 SECONDA TABELLA
    a = 12 * interval_mul; b = 17 * interval_mul;
    smin = floor(random()*(b-a+1)) + a;
    a = 18 * interval_mul; b = 22 * interval_mul;
    smax = floor(random()*(b-a+1)) + a;

    r2.s1 = int4range(smin, smax, '[]');

    -- END QUADRUPLA 1 SECONDA TABELLA
    a = smin + 5 * interval_mul; b = smin + 10 * interval_mul;
    emin = floor(random()*(b-a+1)) + a;
    a = smax + 11 * interval_mul; b = smax + 15 * interval_mul;
    emax = floor(random()*(b-a+1)) + a;

    r2.e1 = int4range(emin, emax, '[]');

ELSE -- le quadruple non si devono intersecare

    -- QUADRUPLA 1 PRIMA TABELLA
    a = 30 * interval_mul; b = 35 * interval_mul;        
    smin = floor(random()*(b-a+1)) + a; 
    a = 36 * interval_mul; b = 40 * interval_mul;        
    smax = floor(random()*(b-a+1)) + a;

    r1.s1 = int4range(smin, smax, '[]');

    -- END QUADRUPLA 1 PRIMA TABELLA
    a = smin + 5 * interval_mul; b = smin + 10 * interval_mul;
    emin = floor(random()*(b-a+1)) + a;
    a = smax + 11 * interval_mul; b = smax + 15 * interval_mul;
    emax = floor(random()*(b-a+1)) + a;

    r1.e1 = int4range(emin, emax, '[]');

    -- QUADRUPLA 1 SECONDA TABELLA
    a = 50 * interval_mul; b = 55 * interval_mul;           
    smin = floor(random()*(b-a+1)) + a;               
    a = 56 * interval_mul; b = 60 * interval_mul;
    smax = floor(random()*(b-a+1)) + a;

    r2.s1 = int4range(smin, smax, '[]');

    -- END QUADRUPLA 1 SECONDA TABELLA
    a = smin + 5 * interval_mul; b = smin + 10 * interval_mul;
    emin = floor(random()*(b-a+1)) + a;
    a = smax + 11 * interval_mul; b = smax + 15 * interval_mul;
    emax = floor(random()*(b-a+1)) + a;

    r2.e1 = int4range(emin, emax, '[]');

END IF;

-- INSERIMENTO NELLE TABELLE
	/*	INSERT INTO t1_im SELECT r1.Attr1, r1.Attr2, r1.s1, r1.d1, r1.s2, r1.d2, r1.s3, r1.d3;
		INSERT INTO t2_im SELECT r2.Attr1, r2.Attr2, r2.s1, r2.d1, r2.s2, r2.d2, r2.s3, r2.d3;
		
		INSERT INTO t1_me SELECT * FROM MakeExplicit(r1.Attr1, r1.Attr2, r1.s1, r1.d1, r1.s2, r1.d2, r1.s3, r1.d3);
		INSERT INTO t2_me SELECT * FROM MakeExplicit(r2.Attr1, r2.Attr2, r2.s1, r2.d1, r2.s2, r2.d2, r2.s3, r2.d3);
		*/
		INSERT INTO t5 SELECT r1.Attr1, r1.Attr2;
		INSERT INTO t6 SELECT r2.Attr1, r2.Attr2;

    INSERT INTO t7 SELECT r1.Attr1, r1.Attr2, r1.s1;
		INSERT INTO t8 SELECT r2.Attr1, r2.Attr2, r2.s1;

    INSERT INTO t2_hyp SELECT r2.*;
	INSERT INTO t1_hyp SELECT r1.*;

    INSERT INTO t1_me_hyp SELECT * FROM MakeExplicitHyp_pref1(r1.Attr1, r1.Attr2, r1.s1, r1.e1, r1.d1);
    INSERT INTO t2_me_hyp SELECT * FROM MakeExplicitHyp_pref1(r2.Attr1, r2.Attr2, r2.s1, r2.e1, r2.d1);

		
	END LOOP;
END; $$
LANGUAGE plpgsql;

select POPOLAMENTO_pref1(1000, 0.1, 0.2,1);
