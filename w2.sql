DECLARE
  TYPE r_person is RECORD(
  fname varchar2(30),
  lname varchar2(30),
  age number);
  
  v_person r_person;
BEGIN
  v_person.fname := 'abc';
  v_person.lname := 'xyz';
  v_person.age := 13;
END;

create table employees(
id number,
fname varchar2(30),
  lname varchar2(30),
  salary number
);
DECLARE
  v_person employees%ROWTYPE;
BEGIN
  v_person.fname := 'abc';
  v_person.lname := 'xyz';
  v_person.salary := 13;
END;


DECLARE
cursor c1 is select fname, lname, salary from employees;
  v_person c1%ROWTYPE;
  V_relative v_person%type;
BEGIN
  v_person.fname := 'abc';
  v_person.lname := 'xyz';
  v_person.salary := 13;
  v_relative := v_person;
END;

DECLARE
  v_person employees%rowtype;
BEGIN
  select *
    into v_person
    from employees
    where id=2;
    
    v_person.salary := v_person.salary * 1.05;
    
    update employees
    set row = v_person
    where id = v_person.id;
    
    v_person.id := 3;
    insert into employees values v_person;
END;

select * from employees;


DECLARE
  TYPE t_varchar2 is TABLE of varchar2(100)
    index by binary_integer;
  TYPE t_number is TABLE of number
    index by binary_integer;
    
    v_fname t_varchar2;
    v_lname t_varchar2;
    v_salary t_number;
    v_index binary_integer;
BEGIN
  select fname, lname, salary
    bulk collect into v_fname,v_lname,v_salary
    from employees;
    /*for i in v_fname.first..v_fname.last loop
      dbms_output.put_line(v_fname(i));
    end loop;*/
    v_index := v_fname.first;
    loop
      exit when v_index is null;
      dbms_output.put_line(v_fname(v_index));
      v_index := v_fname.next(v_index);
    end loop;
END;


declare
  TYPE t_array is TABLE of varchar2(100);
  v_array t_array;
  v_index binary_integer;
begin
  v_array := t_array();
  v_array.extend;
  v_array(1) := 'ddf';
  v_array.extend;
  v_array(2) := 'gg';
  v_array.delete(2);
  dbms_output.put_line(v_array.limit);
end;


declare
  type emp_record is table of employees%rowtype;
  v_employees emp_record;
  v_index binary_integer;
begin
  select *
  bulk collect into v_employees
  from employees;
  
  v_index := v_employees.first;
  
  while v_index is not null loop
    if v_employees(v_index).fname like 'a%' then
      update employees
        set salary = salary * 1.05
        where id = v_employees(v_index).id;
    end if;
    v_index := v_employees.next(v_index);
  end loop;
end;

-- PRAGMA AUTONOMOUS_TRANSACTION;


begin
  for i in reverse 1..10 loop
    if mod(i,2) = 0 then
    dbms_output.put_line(i);
    end if;
  end loop;
end;

declare
  rudeerror Exception;
  pragma exception_init(rudeerror, -20001);
begin
  raise rudeerror;
  dbms_output.put_line(substr('Patryk abcdd', -5,3));
  dbms_output.put_line(instr('Patryk abcdd', 'trym',2));
  --RAISE_APPLICATION_ERROR(-20002,'glupi blad');
end;


declare
  cursor c1(emp_id in employees.id%type) is
    select fname, lname, salary
      from employees
      where id = emp_id;
      
      v_local c1%rowtype;
begin
  open c1(2);
  fetch c1 into v_local;
  close c1;
  
  dbms_output.put_line(v_local.fname);
end;

declare
  cursor c2 is
    select fname, lname, salary
      from employees;
      
      v_local c2%rowtype;
begin
  open c2;
  loop
    fetch c2 into v_local;
    exit when c2%notfound;
    dbms_output.put_line(v_local.fname);
  end loop;
  close c2;
  
end;

declare
  cursor c1 is
    select fname,lname, salary 
      from employees;
begin
  for i in c1 loop
    dbms_output.put_line(i.salary);
  end loop;
end;
create table emp_names(fname varchar(30),lname varchar(30));
declare
  cursor c_emps is
    select fname, lname
      from employees;
  type t_local is table of c_emps%rowtype;
  v_loc_emp t_local;
begin
  select fname, lname
    bulk collect into v_loc_emp
    from employees;
    
  forall i in v_loc_emp.first..v_loc_emp.last
    insert into emp_names
      values v_loc_emp(i);
end;
select * from emp_names;


CREATE OR REPLACE PACKAGE pfirst as
  Function isodd(ab number) return NUMBER as begin
    return mod(ab, 2);
  end;
  procedure pk as begin
    dbms_output.put_line('hello');
  end;
end;
begin
  PACKAGE1.KOMUNKIKAT();
  if PACKAGE1.isodd(5) then
    dbms_output.put_line('tak');
  else
    dbms_output.put_line('nie');
  end if;
end;
create table employs_temp(
id number,
salary number,
times date
);
create or replace trigger au_prac after update on employees for each row when(old.salary > 0)
begin
  
  insert into employs_temp(id,salary, times) values(:old.id, :old.salary,sysdate);
end;

select * from employs_temp;

update employees
  set salary = salary*1.05;