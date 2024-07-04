create proc save_emp_proc
@ename varchar(100),
@eaddress varchar(100),
@esalary decimal(9,2)
as
begin
insert into emp(name,address,salary) values(@ename,@eaddress,@esalary);
end

create proc show_emp_proc
as 
begin
select * from emp;
end

create proc del_emp_proc
@eid int
as
begin
delete from emp where id=@eid;
end

create proc update_emp_proc
@eid int,
@ename varchar(100),
@eaddress varchar(100),
@esalary decimal(9,2)
as
begin
    update emp set name=@ename,address=@eaddress,salary=@esalary where id=@eid;
end

exec save_emp_proc'Shweta','Tirth',89000.00
exec save_emp_proc'pooja','solapur',90000.00

exec show_emp_proc

alter proc insertorupdate
@id int,
@name varchar(100),
@address varchar(100),
@salary decimal(9,2)
as
begin
	if(@id=0)
		begin
			insert into emp(name,address,salary) values(@name,@address,@salary);
		end
	else
		begin
			update emp set name=@name,address=@address,salary=@salary where id=@id;
		end

end

exec insertorupdate 6,'ABC','Solapur',90000.00 
select * from emp;

alter proc CURD_proc
@id int=null,
@name varchar(100)=null,
@address varchar(100)=null,
@salary decimal(9,2)=null,
@choice int
as
begin
	
	if(@choice=1)
		begin
			insert into emp(name,address,salary) values(@name,@address,@salary);
		end
	else if(@choice=2)
		begin
			select * from emp;
		end
	else if (@choice=3)
		begin
		update emp set name=@name,address=@address,salary=@salary where id=@id;
		end
	else if(@choice=4)
		begin
			delete from emp where id=@id;
		end
	else
		begin
			select * from emp where name like '%'+@name+'%';
		end


end

exec CURD_proc @name='Rasika',@address='Latur',@salary=80000.00,@choice=1;

select * from emp;

create table customer
(
cid int primary key identity,
cname varchar(100),
caddress varchar(100)
);

create table product
(
pid int primary key identity,
pname varchar(100),
price int,
cid int,
foreign key (cid) REFERENCES customer(cid)
);

select * from product;

set IDENTITY_INSERT customer on
insert into customer(cid,cname,caddress) values
							(3,'damini','dharashiv'),(4,'pooja','solapur');


insert into product(pname,price) values('Shoes',80000),
('laptop',90000);

create table prod(
pid int primary key identity,
pname varchar(100),
price int
);
alter table prod add cid int;
alter table prod add foreign key (cid) REFERENCES customer(cid)
select * from prod;
select * from customer;

insert into prod values('Shoes',80000,1),
('laptop',90000,2);

select c.cid,cname,caddress,pname,price from customer c inner join prod p on c.cid=p.cid ;

select c.cid,c.cname,c.caddress,p.pname,p.price from customer c left join prod p on c.cid=p.cid ;
select c.cid,c.cname,c.caddress,p.pname,p.price from customer c Right join prod p on c.cid=p.cid ;


create table emps(
eid int primary key,
ename varchar(100),
email varchar(100),
rid int
);
drop table emps;
select * from emps;

insert into emps(eid,ename,email,rid) values(101,'john','john@gmail.com',103),
(102,'Raj','raj@gmail.com',104),
(103,'Rohan','rohan@gmail.com',102),
(104,'mayu','mayu@gmail.com',101);

select e.eid,e.ename,r.ename,r.rid from emps e join emps r on e.eid=r.rid;

select pid from product union select cid from customer;

select pid from product union all select cid from customer ;

select * from emp where salary>=90000;

create clustered index myclustered_index on emp(salary);

exec sp_helpindex 'emp';
create clustered index myindex on emp(id desc);
create clustered index myindex2 on emp(salary asc);

drop index emp.myindex2;
alter table emp drop constraint  PK__emp__3213E83FA44C8E8B;

create nonclustered index myindex3 on emp(salary );

create view myview as select id,name,salary from emp;
select * from emp;
select * from myview;
drop view myview;

alter view myview as select id,name,salary,address from emp;


alter  view myview2 as select * from emp ;
select * from myview2;
insert into myview2(name,salary,address) values('vaishu',20000,'tuljapur');
update myview2 set salary=40000 where id=17;
delete from myview2 where id=16;

create view complex_view as select c.cname,c.caddress,p.pid,p.price from customer c inner join prod p on c.cid=p.pid;
select * from complex_view;


select * from customer;
select * from prod;
exec sp_rename 'complex_view','c_v';
select * from c_v;

alter function fetch_salary(@name as varchar(100))
returns decimal
as
begin
	declare @sal decimal(9,2);
	select @sal=salary from emp where name=@name;
	return @sal;
end

select dbo.fetch_salary('vivan') as emp_name;

create function getEmpDetails(@address varchar(100))
returns Table
as
	return
	select * from emp where address=@address;

select * from getEmpDetails('aherwadi');

alter function AllEmpDetails(@address varchar(100))
returns @result Table
(id int,name varchar(100),salary decimal(9,2),address varchar(100))
as 
begin
	insert into @result
	select * from emp where address=@address;
	return
end

select * from AllEmpDetails('tirth');

select * from emp;

create proc saveEmpProc
@name varchar(100),
@salary decimal(9,2),
@address varchar(100)
As
begin
	insert into emp(name,salary,address) values(@name,@salary,@address);

end

create proc ShowEmpProc
as
begin
	select * from emp;
end

alter table emp add ephoto varchar(100);
select * from emp;

alter proc saveEmpProc
@name varchar(100),
@salary decimal(9,2),
@address varchar(100),
@ephoto varchar(100)
As
begin
	insert into emp(name,salary,address,ephoto) values(@name,@salary,@address,@ephoto);

end

truncate table emp;
select * from emp;

create table manager
(
mid int primary key identity,
mname varchar(100),
mdept varchar(100)
);
insert into manager(mname,mdept) values('alex','HR'),('Robin','IT');
drop table manager;
select * from manager;
select * from employee;
update employee set mid=1 where id=1;

create proc FetchJoinsDataproc
as
begin
select name,dept,email,salary,mname,mdept from employee inner join manager on employee.mid=manager.mid;

end

select name,dept,email,salary,mname,mdept from employee inner join manager on employee.mid=manager.mid;

alter table employee add mid int ;
insert into employee(name,dept,email,salary) values('Robin','Hr','robin@gmail.com',56000);


alter table employee add foreign key (mid) references manager (mid);



insert into student values('Ratan',20),('Rasika',25),('Sima',55),('shweta',45),('Partik',28);

alter proc searchStudentProc
@name varchar(100)=null
as
begin
select * from student where name like '% + @name + %';
end
	

create proc deleteEmpProc
@id int 
as
begin
	 delete from emp where id=@id;
end

select * from emp;

create table product_table
( 
id int primary key identity,
pname varchar(100),
pcat varchar(100),
price decimal(9,2)
);
alter table product_table add pic varchar(100);

select * from product_table;

create proc saveProductProc
@pname varchar(100),
@pcat varchar(100),
@price decimal(9,2),
@pic varchar(100)
as
begin
	insert into product_table values(@pname,@pcat,@price,@pic);
end

select * from product_table;

create proc ShowProductProc
as
begin
	select * from Product_table;
end

create proc DeleteProductProc
@id int
as
begin
	delete from Product_table where id=@id;
end

create proc EditProductProc
@id int
as
begin
	select * from Product_table where id=@id;
end

create proc UpdateProductProc
@pname varchar(100),
@pcat varchar(100),
@price decimal(9,2),
@id int
as
begin
	update Product_table set pname=@pname,pcat=@pcat,price=@price where id=@id;
end


select * from emp;

create table auth
(
auth_id int primary key identity,
auth_user varchar(100),
auth_pass varchar(100),
auth_email varchar(100),
auth_contact varchar(100),
auth_role varchar(100),
auth_profile varchar(100),
auth_status varchar(100)
);

select * from auth;

alter proc auth_proc
@email varchar(100),
@password varchar(100)
as
begin
	select * from auth where auth_email=@email AND auth_pass=@password;
end

alter proc auth_proc
@email varchar(100),
@password varchar(100)
as
begin
	select * from auth where auth_email=@email AND auth_pass=@password;
end


insert into auth values('John','John123','john@gmail.com','7834568990','User','Profile/img.jpg','Active');
select * from auth;
