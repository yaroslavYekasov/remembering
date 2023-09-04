create trigger guestUuendamine
on guest
for update
as
INSERT INTO logi(kuupaev, kasutaja, andmed, tegevus)
select getdate(), user, concat('vanad - ', deleted.first_name, ', ', deleted.last_name, ' uued - ', inserted.first_name, ', ',  inserted.last_name), 'guest on uuendatud'
from deleted inner join inserted
on deleted.id=inserted.id

--kontroll

select * from guest;
update guest set first_name='Luca'
where id=3;
select * from guest;
select * from logi;