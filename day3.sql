declare
  subtype mytyp is char(20 char);
  --subtype closerInt is int range 1..9;
  var1 char(3 byte);
  d mytyp;
  var3 number := 8;
  var4 binary_double := 21d;
  var2 long raw := hextoraw('43'||'41'||'52');
  cursor abcc is select fname, lname from employees;
  type r1 is record(imie varchar2(30), nazwisko varchar2(30));
  a1 Date := SYSDATE;
  a2 Date := '22/05/17';
  i1 Interval year(3) to month;
begin
  i1 := Interval '4' year;
  a1 := a1 + Interval '3' month - Interval '4' year + Interval '17' day;
  dbms_output.put_line(a1);
  dbms_output.put_line(i1);
  for i in abcc
  loopifg 
  null;
  --dbms_output.put_line(i.fname);
  end loop;
end;
 create or replace type o1 is object(imie varchar2(30), nazwisko varchar2(30));
 
declare
  type lista is table of integer;
  a1 lista := lista();
  a2 lista := lista(1,2,3,4,5);
  b lista := lista(3,4);
  n integer := 4;
begin

  if a1 is empty and a1 is a set then
    dbms_output.put_line('pusta');
    end if;
    
  if n member of a2 then
    dbms_output.put_line('czlonek');
  end if;
  
  if b submultiset a2 then
    dbms_output.put_line('tak');
  else
    dbms_output.put_line('nie');
  end if;
  
  case n 
    when 1 then
      dbms_output.put_line('1tt');
    when 2 then
      dbms_output.put_line('2tt');
    when 3 then
      dbms_output.put_line('3tt');
    else
      dbms_output.put_line('brak dopasowan');
  end case;
end;


ALTER SESSION SET PLSQL_CCFLAGS = 'debug:1';
begin
  dbms_output.put_line('session var: ' || $$DEBUG);
  dbms_output.put_line('v1: ' || $$PLSQL_LINE);
  dbms_output.put_line('v2: ' || $$PLSQL_UNIT);
  $IF $$DEBUG = 1 $THEN
    dbms_output.put_line('pre complication true');
  $ELSE
    dbms_output.put_line('pre complication false');
  $END
end;
declare

  type bc is record(fname varchar(30), lname varchar(30));
  abc bc;
begin
  /*select fname, lname
    into abc
    from employees
    where rownum <2;
    dbms_output.put_line(abc.lname);*/
   if sql%found then
    dbms_output.put_line(sql%rowcount);
   else
    dbms_output.put_line('brak');
   end if;
end;


declare
  cursor abb is
    select fname, lname from employees;
  lv_record abb%rowtype;
begin
  open abb;
  loop
    fetch abb into lv_record;
    exit when abb%notfound;
  end loop;
  close abb;
end;

create table tmp_names
 ( fname  varchar(30)
 , lname varchar(30)
 );
 
 



