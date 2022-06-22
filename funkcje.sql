declare
  b number;
  tx varchar2(5);
  source date;
  n1 number := 3.4;
begin
  b := ascii(substr('abc',1,1));
  dbms_output.put_line(b);
  dbms_output.put_line(asciistr('c'));
  dbms_output.put_line(upper('c'));
  dbms_output.put_line(chr(97));
  dbms_output.put_line(concat('im ','here'));
  dbms_output.put_line(initcap('ja jestem tu i u'));
  dbms_output.put_line(instr('to jest docelowy lancuch','to',1/*poz*/,1/*wyst*/));
  dbms_output.put_line(length('c'));
  dbms_output.put_line(lower('vTJTudyYi'));
  dbms_output.put_line(lpad('h'/*ost*/,20/*ile razy*/, ' 8 '/*fragment do dodania*/)); /*rpad*/
  dbms_output.put_line(ltrim('   vTJTudyYi  '));
  dbms_output.put_line(rtrim('   vTJTudyYi  '));
  dbms_output.put_line(trim('   vTJTudyYi  '));
  --dbms_output.put_line(reverse('vTJTudyYi'));
  dbms_output.put_line(replace('to jest abc i tu jest', 'abc','xyz'));
  source := to_date('30-08-07');
  dbms_output.put_line(cast(source as varchar2));
  /*convert('tekst','utf8','asci')*/
  dbms_output.put_line(to_char(n1, '$9,999.90'));
  --dbms_output.put_line(to_date('September 29, 1994 10:00 A.M.', 'Month DD YYYY:MI A.M.'));
  dbms_output.put_line(to_number('$34.20', '$99.99'));
end;


declare
  
begin
  select add_months(to_date('15.08.1988', 'DD.MM.YYYY'),2) as two from dual;
  select to_char(current_date,'MM:YY:DD') as two from dual;
  select to_char(current_timestamp,'MM:YY:DD HH24') as two from dual;
  select dbtimezone from dual;
  select extract(day from to_date('2001-06-14','YYYY-MM-DD')) ff from dual;
  select last_day(sysdate) v from dual;
  select months_between(sysdate, to_date('2001-06-14','YYYY-MM-DD')) v from dual;
  select sysdate + to_dsinterval('10 00:00:00') v from dual;
  select sysdate + to_yminterval('00-02') v from dual;
   select trunc(sysdate)  v from dual;
   select tz_offset('US/Mountain') v from dual;
   
end;

create or replace type list is table of number;
declare
  a LIST := list(3,6,4,3,3,2,4,5,6,7,8,7,8);
  b LIST := list(4,6,8);
  c list := list();
begin
  dbms_output.put_line(cardinality(a));
  dbms_output.put_line(cardinality(set(a)));
  c := a multiset except b;
  c := a multiset intersect b;
  c := a multiset union b;
  c := a multiset union distinct b;
  if b submultiset of a then
    dbms_output.put_line('tak');
  end if;
  select power(2,3) p from dual;
  select abs(remainder(8,15)) r from dual;
  select decode(4,5,'pasuje','nie pasuje') z from dual;
  select greatest(5,8) a from dual;
  select least(5,8) a from dual;
  select nvl(null,5) d from dual;
end;