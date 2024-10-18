use project;

-- retriving all datas 

select * from department;
select * from domain;
select * from eca;
select * from location;
select * from staff;
select * from student;


-- extracting students with eca

select s.student_name,s.eca_id,e.eca_name from student s
inner join eca e
on s.eca_id = e.eca_id; 

-- count of each eca joined by students

select s.eca_id,e.eca_name, count(e.eca_name) from student s
inner join eca e
on s.eca_id = e.eca_id
group by s.eca_id
order by count(e.eca_name) desc;

-- Retrive HSC Domain and its particular domain

select s.student_name,s.hsc_domain_id, d.hsc_main_domain_name from student s
inner join domain d
on s.hsc_domain_id = d.hsc_domain_id
where d.hsc_main_domain_name = 'Mathematics-Computer Science';

-- Retrive domain count done by student:

select s.hsc_domain_id, d.hsc_main_domain_name, count(d.hsc_main_domain_name) from student s
inner join domain d
on s.hsc_domain_id = d.hsc_domain_id
group by s.hsc_domain_id
order by count(d.hsc_main_domain_name) desc;

-- Use rank 

select hsc_domain_id,count(hsc_domain_id), dense_rank() over(partition by hsc_domain_id order by count(hsc_domain_id) desc) as ranked1
from student group by hsc_domain_id

-- Retrive student, staff datas with condition:

select s.student_name,s.staff_id,st.staff_name,st.subject from student s
inner join staff st
on s.staff_id = st.staff_id
where st.staff_name = 'Kumar';

-- Retrive student, department datas with condition:

select s.student_name,s.department_id,d.department_name from student s
inner join department d
on s.department_id = d.department_id
where d.department_name = 'Science';

-- Count of Each deparment:

select s.department_id,d.department_name,count(d.department_name) as counts from student s
inner join department d
on s.department_id = d.department_id
group by s.department_id;

-- Retrive highest course enrolled using rank and limit

select s.department_id,d.department_name,count(d.department_name),rank() over(order by count(d.department_name) desc) from student s
inner join department d
on s.department_id = d.department_id
group by s.department_id
limit 1;

-- Retrive the highest ranked from derived table

select department_id,rank() over(order by department_id) as ranked from 
(select department_id,count(department_id) from student group by department_id order by count(department_id) desc) as test limit 1;

-- Retrive student Location datas:

select s.student_name,s.location_id,l.location_name from student s
inner join location l
on s.location_id = l.location_id
where l.location_name = 'Chennai';

-- Count of each location of students:

select s.location_id,l.location_name,count(s.location_id) from student s
inner join location l
on s.location_id = l.location_id
group by s.location_id;

-- Retrive staff Location datas:

select st.staff_name,st.location_id,l.location_name from staff st
inner join location l
on st.location_id = l.location_id
where l.location_name = 'Chennai';

-- Count of each location of students:

select st.location_id,l.location_name,count(st.location_id) from staff st
inner join location l
on st.location_id = l.location_id
group by st.location_id;

-- Retrive staff,location name:

select st.staff_name,st.location_id,l.location_name from staff st
inner join location l 
on  st.location_id = l.location_id;

-- Retrive staff,department name:

select st.staff_name,st.department_id,d.department_name from staff st
inner join department d
on st.department_id = d.department_id;

-- create view for staff,location:

create view st_location as 
select st.staff_name,st.location_id,l.location_name from staff st
inner join location l 
on  st.location_id = l.location_id;

-- Retrive View data:

select location_name, count(location_name) from st_location group by location_name;

-- Retrive maximum count of location from view table:

select max(lcc) as maximum from (select location_id, count(location_id) as lcc from st_location group by location_id) as dd ;

-- Retrive the the eca data who enrolled more than 5 on same group using sub query
 
select eca_id,count(eca_id) from student 
group by eca_id
having count(eca_id) >
(select count(eca_id) from student
group by eca_id
having count(eca_id) =5);

-- Create view for student,eca datas

create view std_eca as 
select s.student_id,s.student_name,s.eca_id,e.eca_name from student s
inner join eca e
on s.eca_id = e.eca_id;

-- Retrive view data:
select * from std_eca;

-- Use case when expression:

select *,
case eca_name
when 'Music Band' then 'MSB'
when 'Sports Club' then 'STC'
when 'Robotics Team' then 'RTT'
when 'Photography Club' then 'PGC'
when 'Dance Club' then 'DNC'
else 'Others'
end as 'Aliase'
from std_eca;

-- Create table for audit:

create table student_audit(
id varchar(20) not null,
details char(5) not null,
duration datetime not null); 

-- Create after insert trigger

create trigger insert_trigg_table
after insert on department 
for each row
insert into student_audit values(new.department_id,'ins',now());

-- Inserting the value in department table:

insert into department values('DEP010','Swimming');
select * from student_audit;

-- Create after update trigger

create trigger update_trigg_table
after update on department
for each row
insert into student_audit values(new.department_id,'upd',now());

-- Updating the value in department table

update department set department_name = 'Robotics' where department_id = 'DEP010';
select * from student_audit;

-- Create before update trigger

create trigger bfr_update_trigg_table
before update on department
for each row
insert into student_audit values(old.department_id,'upd',now());

-- Updating the value in department table

update department set department_name = 'Cook' where department_id = 'DEP010';
select * from student_audit;

-- Create after delete trigger

create trigger del_trigger_table
after delete on department
for each row
insert into student_audit values(old.department_id,'del',now());

-- Delete the value in department table

delete from department where department_id = 'DEP010';
delete from department where department_id = 'DEP009';
select * from department;
select * from student_audit;

-- create store procedure for all the table:

create procedure dep()       -- department
select * from department;

create procedure domain()    -- domain
select * from domain;

create procedure eca()       -- eca
select * from eca;

create procedure loc()       -- location
select * from location;

create procedure staff()      -- staff
select * from staff;

create procedure stdt()       -- student
select * from student;

-- Retriving stored procedure datas:

call dep();
call domain();
call eca();
call loc();
call staff();
call stdt();

-- Create Delimiter

delimiter ##
create procedure std_staff()      -- student table
begin 
select * from student where staff_id = 'ST001';
select * from student where staff_id = 'ST003';
end ##
delimiter ;

-- Calling the procedure

call std_staff();

-- Wild Card:

select * from student where student_name like 'Aa%';

-- TCL (rollback,savepoint,commit):

start transaction;
savepoint test1;
delete from student where student_id = 1;
select * from student;   -- Calling the table to check
rollback to test1;

-- DCL (grant, revoke):  grant select,insert on class_work_new.* to Antony;

grant select,insert on project.* to employee_A;


