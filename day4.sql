create or replace type
  sql_varray is varray(3) of varchar2(30);

DECLARE
  lv_stOGE SQL_VARRAY := sql_varray('Moe', 'Larry');
BEGIN
  dbms_output.put_line('Aktualna liczba: ' || lv_stOGE.count || ', max liczba: ' || lv_stOGE.limit);
  lv_stOGE.EXTEND;
  
  dbms_output.put_line('Aktualna liczba: ' || lv_stOGE.count || ', max liczba: ' || lv_stOGE.limit);
  lv_stOGE(lv_stOGE.count) := 'walka';
  
  FOR i IN 1..lv_stOGE.COUNT LOOP
    dbms_output.put_line(lv_stOGE(i));
  END LOOP;
END;



CREATE OR REPLACE TYPE sql_table IS TABLE OF VARCHAR(20);

SELECT column_value
FROM TABLE(sql_varray('abx','dca','let'))
ORDER BY 1;

CREATE TABLE osoba
( id_os     number
, imie      varchar(20)
, nazwisko  varchar(20)
, wiek      number
, id_prac   number
);

CREATE TABLE praca
( id_prac    number
, pensja     number
, zawod      VARCHAR(20)
);

INSERT INTO osoba
( id_os     
, imie 
, nazwisko
, wiek
, id_prac
) values 
( 3
, 'let'
, 'make'
, 19
, 3
);

INSERT INTO praca
( id_prac    
, pensja    
, zawod      
) values
( 3
, 1
, 'worker'
)

alter table osoba add foreign key(id_prac) references praca(id_prac)
update (select *
from osoba join praca using(ID_PRAC))
set wiek= wiek+1,
pensja=pensja+3;

DECLARE
  lv_stOGE SQL_TABLE := sql_table('Moe', 'Larry');
  ind NUMBER;
BEGIN
  dbms_output.put_line('Aktualna liczba: ' || lv_stOGE.count /*|| ', max liczba: ' || lv_stOGE.limit (no limit)*/);
  lv_stOGE.EXTEND;
  
  dbms_output.put_line('Aktualna liczba: ' || lv_stOGE.count  /*|| ', max liczba: ' || lv_stOGE.limit (no limit)*/);
  lv_stOGE(lv_stOGE.count) := 'walka';
  ind :=lv_stOGE.count;
  lv_stOGE.EXTEND;
  dbms_output.put_line('Aktualna liczba: ' || lv_stOGE.count  /*|| ', max liczba: ' || lv_stOGE.limit (no limit)*/);
  lv_stOGE(lv_stOGE.count) := 'walka'; 
  lv_stOGE.DELETE(ind);
  ind := lv_stOGE.FIRST;
  WHILE ind <= lv_stOGE.LAST LOOP
    dbms_output.put_line(lv_stOGE(ind));
    ind := lv_stOGE.next(ind);
  END LOOP;
  
  FOR i IN lv_stOGE.FIRST..lv_stOGE.LAST LOOP
    IF lv_stOGE.EXISTS(i) THEN
      dbms_output.put_line(lv_stOGE(i));
    END IF;
  END LOOP;
END;

CREATE OR REPLACE TYPE prominent_object IS OBJECT
( name          VARCHAR2(20)
, age           VARCHAR2(10));

CREATE OR REPLACE TYPE people_object IS OBJECT
( race          VARCHAR2(20)
, exemplar      PROMINENT_OBJECT);

CREATE OR REPLACE TYPE people_table IS TABLE OF people_object;

-- prior, trim,limit,exists
DECLARE
  TYPE tba IS TABLE OF o_person index by binary_integer;
  o1 tba;
BEGIN
  o1(4) := o_person('john','doe',17);
  dbms_output.put_line(o1(4).lname);
END;

DECLARE
  e EXCEPTION;
BEGIN
  RAISE e;
  dbms_output.put_line('not execute ');
  EXCEPTION WHEN OTHERS THEN
    IF SQLCODE = 1 THEN
      dbms_output.put_line('error code 1 ' || SQLERRM);
    END IF;
END;


DECLARE
  e EXCEPTION;
  PRAGMA EXCETION_INIT(e,-20001);
BEGIN
  RAISE_APPLICATION_ERROR(-20001, 'KOMPUTER WYBOCHL');
  dbms_output.put_line('not execute ');
  EXCEPTION WHEN e THEN
    dbms_output.put_line(SQLERRM);
END;
