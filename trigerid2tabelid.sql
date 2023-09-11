--SQL SERVER----------------------------------------------------------------------------------------------------------


--loonud tabeli guest
create table guest (
id int primary key identity(1,1),
first_name varchar(20),
last_name varchar(20) null,
member_since date 
);

--loonud tabeli reservation teisese võtmega guest_id
create table reservation(
id int primary key identity(1,1),
date_in date,
date_out date,
made_by varchar(20),
guest_id int FOREIGN KEY REFERENCES guest(id)
);

--logi tabel
create table logi(
id int primary key identity(1,1),
andmed text,
kuupaev datetime,
kasutaja varchar(100)
);

--Guesti täitmine
INSERT INTO guest (first_name, last_name, member_since)
VALUES
    ('Ivan', 'Smirnov', '2018-05-15'),
    ('Natalya', 'Popova', '2019-02-28'),
    ('Sergei', 'Kuznetsov', '2020-11-10'),
    ('Olga', 'Vasilieva', '2017-09-22'),
    ('Dmitri', 'Romanov', '2021-07-04');

--Täitmine reservatsioon
INSERT INTO reservation (date_in, date_out, made_by, guest_id)
VALUES
    ('2023-09-10', '2023-09-15', 'Natalya Popova', 2),
    ('2023-08-20', '2023-08-25', 'Sergei Kuznetsov', 3),
    ('2023-10-05', '2023-10-10', 'Ivan Smirnov', 1),
    ('2023-11-18', '2023-11-22', 'Olga Vasilieva', 4),
    ('2023-09-05', '2023-09-09', 'Dmitri Romanov', 5);

--kontrollimine
select * from guest;
select * from reservation;
select * from logi;

--Triger lisamine
create trigger reslisamine
on reservation
for insert
as
insert into logi(kuupaev, andmed, kasutaja)
select getdate(),
concat(inserted.made_by, ', ', g.first_name),
user
from inserted
inner join guest g on g.id=g.id

--kontrollimine
INSERT INTO reservation (date_in, date_out, made_by, guest_id)
VALUES
    ('2023-09-10', '2023-09-15', 'Luca Gluh', 2);
select * from reservation
select * from logi


--Triger uuendamisel
create trigger resuuendamine
on reservation
for update
as
insert into logi(kuupaev, andmed, kasutaja)
select getdate(),
concat('Vanad andmed: ', deleted.made_by, ', ', g1.first_name, 'Uued: ', inserted.made_by, ', ', g1.first_name),
user
from deleted
inner join inserted on deleted.id=inserted.id
inner join guest g1 on deleted.id=g1.id
inner join guest g2 on inserted.id=g2.id

--kontrollimine
select * from reservation;
update reservation set guest_id=1
where made_by='Luca Gluhov'
select * from reservation;
select * from logi;


--XAMPP----------------------------------------------------------------------------------------------------------


