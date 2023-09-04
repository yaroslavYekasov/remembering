--lisamine ja SELECT

create procedure lisaGuest
@fname varchar(100),
@lname varchar(100),
@sinse date
as
begin
insert into guest(first_name, last_name, member_since)
values(@fname, @lname, @sinse);
select * from guest;
select * from logi;
end;

exec lisaguest 'Denis', 'Gorjunov', '2002-10-9';

--kustutamine ja SELECT

create procedure kustutaGuest
@ID int
as
begin
select * from guest;
delete from guest
where @id=id;
select * from guest;
select * from logi;
end;

exec kustutaGuest 3;

--count

create procedure countGuests
as
begin
    declare @count int;
    select @count = count(*) from guest;
    select @count as 'GuestCount';
end;

exec countGuests;
