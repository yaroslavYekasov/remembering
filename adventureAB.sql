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