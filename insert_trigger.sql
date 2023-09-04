create trigger guestLisamine
on guest
for insert
as
INSERT INTO logi(kuupaev, kasutaja, andmed, tegevus)
select getdate(), user, concat(inserted.first_name, ', ', inserted.last_name), 'guest on lisatud'
from inserted

--kontroll

INSERT INTO guest (first_name, last_name, member_since)
VALUES ('Ivan', 'Smirnov', '2018-05-15');
select * from guest
select * from logi