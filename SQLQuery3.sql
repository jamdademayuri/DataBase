create database fullstack;

use fullstack;

create table emp( id int primary key identity,
				name varchar(100),
				dept varchar(100),
				salary decimal(9,2)
				);

select * from emp;

select * from sample;

drop table sample;

alter table emp add address varchar(100);

alter table emp drop column dept;
