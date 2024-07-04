create table auth_ex
(
auth_id int primary key identity,
auth_user varchar(100),
auth_pass varchar(100),
auth_email varchar(100),
auth_contact varchar(100),
auth_Role varchar(100),
auth_profile varchar(100),
auth_status varchar(100)
);


select * from auth_ex;

alter proc authentication_Login
@email varchar(100),
@password varchar(100)
as
begin
	select * from auth_ex where (auth_email=@email or auth_user=@email) AND auth_pass=@password;
end

create proc RegUserProc
@auth_user varchar(100),
@auth_pass varchar(100),
@auth_email varchar(100),
@auth_contact varchar(100),
@auth_Role varchar(100),
@auth_profile varchar(100),
@auth_status varchar(100)
as
begin	
	insert into auth_ex values(@auth_user,@auth_pass,@auth_email,@auth_contact,@auth_Role,@auth_profile,@auth_status); 
end


insert into auth_ex values('Mayuri','Mayuri123','mayuri@gmail.com','9130354320','Admin','profile/img.jpg','Active');
insert into auth_ex values('John','john123','john@gmail.com','9137890867','User','profile/img.jpg','Active');
insert into auth_ex values('Tushar','tushar123','tushar@gmail.com','9137890867','User','profile/img.jpg','Active');

update auth_ex set auth_status='Deactive' where auth_id=3;
select * from auth_ex;
truncate table auth_ex;
update auth_ex set auth_email='mayuri@gmail.com' where auth_id=1;

alter proc auth_UserListProc
as
begin
	select * from auth_ex where auth_Role='User';
end

create proc UserSearchProc
@user varchar(100)
as
begin
	select * from auth_ex where auth_user like '%'+@user+'%';
end

create proc UserDeleteProc
@id int
as
begin
	delete from auth_ex where auth_id=@id;
end

alter proc UserResetPassProc
@email varchar(100),
@npass varchar(100),
@cpass varchar(100)
as
begin
	update auth_ex set auth_pass=@cpass where auth_email=@email;
end

create proc CheckProfileProc
@Sessdata varchar(100)
as
begin
	select * from auth_ex where auth_email=@Sessdata or auth_user=@Sessdata;
end

create proc UserStatusProc
@status varchar(100),
@id int
as
begin
	update auth_ex set auth_status=@status where auth_id=@id;
end

create proc UserFindByID
@id int
as
begin
	select * from auth_ex where auth_id=@id;
end

select * from auth_ex;
update auth_ex set auth_email='jamdademayurin@gmail.com' where auth_id=1;

