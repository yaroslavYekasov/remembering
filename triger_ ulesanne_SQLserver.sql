create table room(
id int primary key identity(1,1),
number varchar(10),
name_ varchar(40),
status_ varchar(10),
smoke bit,
);

create trigger roomLisamine
on room
for insert
as
INSERT INTO logi(kuupaev, kasutaja, andmed, tegevus)
select getdate(), user, concat(inserted.number, ', ', inserted.name_, ', ', inserted.status_, ', ', inserted.smoke), 'guest on lisatud'
from inserted

--kontroll

INSERT INTO room (number, name_, status_, smoke)
VALUES ('102', 'Sunny Suite', 'Vacant', 0)
select * from room
select * from logi



create trigger roomKustutamine
on room
for delete
as
INSERT INTO logi(kuupaev, kasutaja, andmed, tegevus)
select getdate(), user, concat(deleted.number, ', ', deleted.name_, deleted.status_, ', ', deleted.smoke), 'guest on kustatud'
from deleted

--kontroll

delete from room where id=1
select * from room;
select * from logi;



create trigger roomUuendamine
on room
for update
as
INSERT INTO logi(kuupaev, kasutaja, andmed, tegevus)
select getdate(), user, concat('vanad - ', deleted.number, ', ', deleted.name_, deleted.status_, ', ', deleted.smoke, ' uued - ', inserted.number, ', ', inserted.name_, ', ', inserted.status_, ', ', inserted.smoke), 'guest on uuendatud'
from deleted inner join inserted
on deleted.id=inserted.id

--kontroll

select * from room;
update room set number='911'
where id=2;
select * from room;
select * from logi;