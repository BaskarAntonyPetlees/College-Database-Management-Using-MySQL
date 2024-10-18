create database project
use project

create table location(
location_id varchar(50) primary key,
location_name varchar(50) not null);

create table department(
department_id varchar(50) primary key,
department_name varchar(50) not null);

create table eca(
eca_id varchar(50) primary key,
eca_name varchar(50) not null);

create table staff(
staff_id varchar(20) primary key,
staff_name varchar(50) not null,
subject varchar(50) not null,
department_id varchar(50) null,
location_id varchar(50) null,
foreign key(location_id) references location(location_id),
foreign key(department_id) references department(department_id));

create table domain(
hsc_domain_id varchar(50) primary key,
hsc_main_domain_name varchar(50) not null);

create table student(
student_id int primary key,
student_name varchar(50) not null,
location_id varchar(20) not null,
staff_id varchar(20) not null,
hsc_domain_id varchar(50) not null,
department_id varchar(20) not null,
eca_id varchar(50) not null,
foreign key(location_id) references location(location_id),
foreign key(staff_id) references staff(staff_id),
foreign key(hsc_domain_id) references domain(hsc_domain_id),
foreign key(department_id) references department(department_id),
foreign key(eca_id) references eca(eca_id));

insert into location values('LOC001', 'Chennai'),
('LOC002', 'Coimbatore'),
('LOC003', 'Madurai'),
('LOC004', 'Salem'),
('LOC005', 'Kanyakumari'),
('LOC006', 'Tiruchirappalli'),
('LOC007', 'Erode'),
('LOC008', 'Kanchipuram'),
('LOC009', 'Dharmapuri'),
('LOC010', 'Virudhunagar');

insert into domain values('HSC001','Mathematics-Computer Science'),           
('HSC002','Mathematics-Biology'),                                 
('HSC003','Computer Science-Accountancy'),              
('HSC004','Economics-Business Studies'); 

insert into eca values('ECA001','Music Band'),
('ECA002','Sports Club'),
('ECA003','Robotics Team'),
('ECA004','Photography Club'),
('ECA005','Dance Club');

insert into department values('DEP001','Engineering'),           
('DEP002','Science'),                   
('DEP003','Arts');

select * from staff;
select * from location;
select * from student;

insert into staff(staff_id,staff_name,subject,department_id,location_id) values('ST011','Raghavan','Ecology','DEP003','LOC001'),                 
('ST012','Suresh','Cognitive Psychology','DEP003','LOC002'), 
('ST013','Ravi','Social Theory','DEP003','LOC003'); 

insert into student values(10, 'Jai Prakash', 'LOC010', 'ST009', 'HSC002', 'DEP001', 'ECA005'),  
(11,  'Kavya Menon','LOC001','ST004','HSC003','DEP002','ECA001'),      
(12,'Lakshmi Narayan','LOC002','ST012','HSC004','DEP003','ECA002'),          
(13,'Mohan Rao','LOC003','ST010','HSC001','DEP001','ECA003'),       
(14,'Neha Iyer','LOC004','ST003','HSC002','DEP001','ECA005'),           
(15,'Aarav Sharma','LOC005','ST006','HSC003','DEP002','ECA001'),         
(16,'Bhavya Suresh','LOC006','ST007','HSC004','DEP003','ECA002'),           
(17,'Chaitanya Reddy','LOC007','ST001','HSC001','DEP001','ECA003'),   
(18,'Devika Nair','LOC008','ST005','HSC002','DEP002','ECA004'),        
(19,'Ekta Kapoor','LOC009','ST011','HSC003','DEP003','ECA005'),        
(20,'Faisal Khan','LOC010','ST009','HSC004','DEP001','ECA001'),    
(21,'Gauri Patil','LOC001','ST006','HSC001','DEP002','ECA002'),           
(22,'Harsh Vardhan','LOC002','ST013','HSC002','DEP003','ECA003'),    
(23,'Ishaan Verma','LOC003','ST010','HSC003','DEP001','ECA004'),    
(24,'Jasmin Singh','LOC004','ST004','HSC004','DEP002','ECA005'), 
(25,'Kiran Rao','LOC005','ST008','HSC001','DEP003','ECA001'),              
(26,'Lata Mangeshkar','LOC006','ST009','HSC002','DEP001','ECA002'),              
(27,'Manish Tiwari', 'LOC007', 'ST001', 'HSC003', 'DEP001', 'ECA003'), 
(28,'Nisha Gupta', 'LOC008', 'ST006', 'HSC004', 'DEP002', 'ECA004'), 
(29,'Omi Sharma', 'LOC009', 'ST013', 'HSC001', 'DEP003', 'ECA005'),   
(30,'Pooja Bhatia', 'LOC010', 'ST010', 'HSC002', 'DEP001', 'ECA001');


select * from department;
select * from domain;
select * from eca;
select * from location;
select * from staff;
select * from student;

select staff_id, count(staff_id) from student group by staff_id order by count(staff_id) desc;
select hsc_domain_id, count(hsc_domain_id) from student group by hsc_domain_id order by count(hsc_domain_id) desc;
select department_id, count(department_id) from student group by department_id order by count(department_id) desc;
select eca_id, count(eca_id) from student group by eca_id order by count(eca_id) desc;













