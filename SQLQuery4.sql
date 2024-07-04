
select * from emp;

set IDENTITY_INSERT emp on

insert into emp (ID ,name,salary,address) values(101,'mayu',12000.90,'Tuljapur'),
												(102,'maya',12500.90,'Thane');

	delete from emp where id=101;

	delete from emp;
	truncate table emp;

	select * from emp where name like '% b %';