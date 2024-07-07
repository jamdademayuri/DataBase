create table user_account
(
id int primary key identity,
acc_user varchar(100),
acc_pass varchar(100),
acc_email varchar(100),
acc_role varchar(100)
);

select * from user_account;

alter proc NewUserAccountProc
@acc_user varchar(100),
@acc_pass varchar(100),
@acc_email varchar(100),
@acc_role varchar(100),
@acc_profile varchar(100)
as
begin
	insert into user_account values(@acc_user,@acc_pass,@acc_email,@acc_role,@acc_profile);
end

truncate table user_account;
alter table user_account add acc_profile varchar(100);

insert into user_account values('Admin','Admin123','admin@gmail.com','Admin','Profiles/download1.jpeg');

create proc UserLoginProc
@acc_email varchar(100),
@acc_pass varchar(100)
as
begin
	select * from user_account where acc_email=@acc_email AND acc_pass=@acc_pass;
end


create proc UserExistProc
@acc_user varchar(100),
@acc_email varchar(100)
as
begin
	select * from user_account where acc_user=@acc_user OR acc_email=@acc_email;
end

create proc FindProfileByID
@acc_email varchar(100)
as
begin
	select * from user_account where acc_email=@acc_email;
end

create proc DeleteAccountProc
@id int
as
begin
	delete from user_account where id=@id;
end

create proc ChnageProfileProc
@acc_profile varchar(100),
@acc_email varchar(100)
as
begin
	update user_account set acc_profile=@acc_profile where acc_email=@acc_email ;
end

select * from user_account;

create proc UserListProc
as
begin
	select * from user_account where acc_role='User';
end

drop table product_table;

select * from product;

create table product
(
pid int primary key identity,
pname varchar(100),
pcat varchar(100),
price decimal(9,2),
pic varchar(100),
mdt varchar(100)
);

create proc AddProductProc
@pname varchar(100),
@pcat varchar(100),
@price decimal(9,2),
@pic varchar(100),
@mdt varchar(100)
as
begin
	insert into product values(@pname,@pcat,@price,@pic,@mdt);
end

truncate table product;

create table cart
(
pid int primary key identity,
pname varchar(100),
pcat varchar(100),
price decimal(9,2),
qty int,
pic varchar(100),
dt varchar(100),
suser varchar(100)
);
 
 alter table cart add perprice decimal(9,2);
 select * from cart;
 truncate table cart;

alter proc AddToCartProc
@pname varchar(100),
@pcat varchar(100),
@price decimal(9,2),
@qty int,
@pic varchar(100),
@dt varchar(100),
@suser varchar(100),
@perprice decimal(9,2)
as
begin
	insert into cart values(@pname,@pcat,@price,@qty,@pic,@dt,@suser,@perprice);
end

truncate table cart;
create proc FindProductByID
@pid int
as
begin
	select * from product where pid=@pid;
end

exec FindProductByID 4;

create proc FindCartDetailsBySession
@suser varchar(100)
as
begin
	select * from cart where suser=@suser; 
end

create proc DeleteCartProductProc
@pid int
as
begin
	delete from cart where pid=@pid;
end

create proc DeleteCartProc
@pid int
as
begin	delete from cart where pid=@pid;
end

create table placeorder
(
	pid int primary key identity,
	pname varchar(100),
	pcat varchar(100),
	price decimal(9,2),
	qty int,
	pic varchar(100),
	dt varchar(100),
	suser varchar(100),
	perprice decimal(9,2)
);

alter table placeorder add contact varchar(100);

select * from placeorder;
select * from cart;
truncate table cart;
truncate table placeorder;

/*insert into placeorder(pid,pname,pcat,price,qty,pic,dt,suser,perprice) select * from cart;
*/
select * into placeorder from cart;

alter table placeorder add pstatus varchar(100);

create proc deleteproductcartproc
@suser varchar(100)
as
begin
	delete from cart where suser=@suser;
end

select * from cart;


alter table placeorder drop column status;
truncate table product;