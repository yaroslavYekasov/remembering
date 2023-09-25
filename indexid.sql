--Mitme avaldisega tabeliväärtusega funktsioonid

Create Function fn_ILTVF_GetEmployees()
Returns Table
as
Return (Select EmployeeKey,FirstName,Cast(BirthDate as Date) as DOB From DimEmployee);

Select * from fn_ILTVF_GetEmployees();


create Function fn_MSTVF_GetEmployees2()
Returns @Table Table (Id int, Name varchar(20), DOB Date)
as
Begin
Insert into @Table
Select EmployeeKey, FirstName,CAST(BirthDate as Date)
From DimEmployee
Return
End

select * from fn_MSTVF_GetEmployees();

Update fn_MSTVF_GetEmployees2() set Name='Sam 1' where id=1
select * from fn_MSTVF_GetEmployees2();

--Funktsiooniga seotud tähtsad kontseptsioonid

create function fn_GetEmployeeNameBuild(@id int)
Returns varchar(20)
as
Begin
Return(Select FirstName from DimEmployee where EmployeeKey=@id)
end

select dbo.fn_GetEmployeeNameBuild(1);



alter Function fn_GetEmployeeNameBuild(@Id int)
returns varchar(20)
with Encryption
as
Begin
Return (Select FirstName from dbo.DimEmployee where EmployeeKey = @Id)
End

select dbo.fn_GetEmployeeNameBuild(1);


drop table DimEmployee


--Ajutised tabelid

CREATE TABLE #PersonDetails(
Id int PRIMARY KEY,
Name VARCHAR(20))

INSERT INTO #PersonDetails VALUES(1,'Artem')
INSERT INTO #PersonDetails VALUES(2,'Matvei')
INSERT INTO #PersonDetails VALUES(3,'Sasha')
SELECT * FROM #PersonDetails

SELECT name FROM  tempdb.sys.all_objects
WHERE name LIKE '#PersonDetails%'



CREATE PROCEDURE spCreateLocalTempTable
AS
BEGIN
CREATE TABLE #PersonDetails(
Id int PRIMARY KEY,
Name VARCHAR(20))

INSERT INTO #PersonDetails VALUES(1,'Artem')
INSERT INTO #PersonDetails VALUES(2,'Matvei')
INSERT INTO #PersonDetails VALUES(3,'Sasha')
SELECT * FROM #PersonDetails
END

EXEC spCreateLocalTempTable

CREATE TABLE ##EmployeeDetails(Id int, Name NVARCHAR(20))
SELECT * FROM ##EmployeeDetails


--Ineksid serveris

select * from DimEmployee
select * from DimEmployee where BaseRate > 35 and BaseRate <50



create index IX_DimEmployee  where BaseRate > 35 and BaseRate < 50

Create index IX_DimEmployee_BaseRate 
on DimEmployee (BaseRate ASC)

select top 10 * from DimEmployee order by IX_DimEmployee_BaseRate

exec sys.sp_helpindex @Objname='DimEmployee'

drop index DimEmployee.IX_DimEmployee_BaseRate

36. Klastreeritud ja mitte-klastreeritud indeksid

select * from DimEmployee;

execute sp_helpindex [tbEmployee];

create table [tbEmployee]
(
[id] int Primary Key,
[Name] nvarchar(50),
[Salary] int,
[Gender] nvarchar(10),
[City] nvarchar(10)
)

insert into [tbEmployee] Values(3,'John',4500,'Male','New York')
insert into [tbEmployee] Values(1,'Don',3400,'Male','London')
insert into [tbEmployee] Values(4,'Gan',6500,'Female','Tokyo')
insert into [tbEmployee] Values(5,'Pid',2100,'Female','Toronto')
insert into [tbEmployee] Values(2,'Onas',2400,'Male','Sydney')

Select * from [tbEmployee]

create Clustered Index IX_tbEmployee_Name
ON [tbEmployee](Name)

Drop index [tbEmployee].PK__tbEmploy__3213E83F65501ADA

create Clustered index IX_tblEmployee_Gender_Salary
on tbEmployee(Gender desc, Salary ASC)

Select * from tbEmployee

create NonClustered index IX_tbEmployee_Name
on tbEmployee(Name)

37. Unikaalne ja mitte-unikaalne indeks

create table [tbEmployee]
(
[id] int Primary Key,
[Name] nvarchar(50),
[Salary] int,
[Gender] nvarchar(10),
[City] nvarchar(10)
)

execute sp_helpindex [tbEmployee];

insert into [tbEmployee] Values(1,'John',4500,'Male','New York')
insert into [tbEmployee] Values(1,'Don',3400,'Male','London')

drop index tbEmployee.PK__tbEmploy__3213E83F55419F46

Create Unique NonClustered Index UIX_tblEmployee_Name_City
on tbEmployee(Name desc, City ASC)

ALTER TABLE tbEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

CREATE UNIQUE INDEX IX_tblEmployee_City
ON tbEmployee(City)
WITH IGNORE_DUP_KEY



