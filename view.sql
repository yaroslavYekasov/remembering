--39. View SQL serveris

create table tblEmployee
(
Id int Primary Key,
Name nvarchar(30),
Slary int,
Gender nvarchar(10),
DepartmentId int
)

create table tblDepartment
(
DeptId int Primary key,
DeptName nvarchar(20)
)

insert into tblDepartment values (1, 'IT')
insert into tblDepartment values (2, 'Payroll')
insert into tblDepartment values (3, 'HR')
insert into tblDepartment values (4, 'Admin')
insert into tblDepartment values (5, 'Stack')

insert into tblEmployee values (1, 'Luca', 3400, 'Male', 3)
insert into tblEmployee values (2, 'Max', 2300, 'Female', 1)
insert into tblEmployee values (3, 'Katya', 5000, 'Female', 2)
insert into tblEmployee values (4, 'Dasha', 1200, 'Male', 4)
insert into tblEmployee values (5, 'Masha', 6500, 'Female', 1)

select * from tblDepartment

select * from tblEmployee

select Id, Name, Slary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId

create view vWEmployeesByDepartment
as
Select  Id, Name, Slary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId

select * from vWEmployeesByDepartment

create view vWITDepartment_Employees2
as
select Id, Name, Slary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId
where tblDepartment.DeptName='IT'

select * from vWITDepartment_Employees2




create view vWEmployeesNonConfidentialData
as
select Id, Name, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId

select * from vWEmployeesNonConfidentialData


create view vwEmployeesCountByDepartment
as
select DeptName, COUNT(id) as TotalEmployees
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId
Group by DeptName

select * from vwEmployeesCountByDepartment

--40. View uuendused


create view vWEmployeesDataExceptionSalary
as
select Id, Name, Gender, DepartmentId
from tblEmployee

select * from vWEmployeesDataExceptionSalary

update vWEmployeesDataExceptionSalary
set Name = 'Mikey' Where Id = 2

delete from vWEmployeesDataExceptionSalary where Id = 2
insert into vWEmployeesDataExceptionSalary values (2, 'Mikey', 'Male', 2)

create view vwEmployeeDetailsByDepartment
as
select Id, Name, Slary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.Deptid

select * from vwEmployeeDetailsByDepartment


Update vwEmployeeDetailsByDepartment
set DeptName='IT' where Name='John'

--41. Indekseeritud view-d

create table tblProduct
(
ProductId int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into tblProduct Values(1, 'Books', 20)
insert into tblProduct Values(2, 'Pens', 14)
insert into tblProduct Values(3, 'Pencils', 11)
insert into tblProduct Values(4, 'Clips', 10)

create table tblProductSales
(
ProductId int,
QuantitySold int
)

Insert into tblProductSales values(1, 10)
Insert into tblProductSales values(3, 23)
Insert into tblProductSales values(4, 21)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 13)
Insert into tblProductSales values(3, 12) 
Insert into tblProductSales values(4, 13) 
Insert into tblProductSales values(1, 11)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 14)

Create view vWTotalSalesByProduct
with SchemaBinding
as
Select Name,
SUM(ISNULL((QuantitySold * UnitPrice), 0)) as TotalSales,
COUNT_BIG(*) as TotalTransactions
from dbo.tblProductSales
join dbo.tblProduct
on dbo.tblProduct.ProductId = dbo.tblProductSales.ProductId
group by Name
select * from vWTotalSalesByProduct


Image
Create Unique Clustered Index UIX_vWTotalSalesByProduct_Name
on vWTotalSalesByProduct(Name)

select * from vWTotalSalesByProduct

--42. View piirangud

CREATE TABLE tblEmployee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)

Insert into tblEmployee values (1,'John', 5000, 'Male', 3)
Insert into tblEmployee values (2,'Mike', 3400, 'Male', 2)
Insert into tblEmployee values (3,'Pam', 6000, 'Female', 1)
Insert into tblEmployee values (4,'Todd', 4800, 'Male', 4)
Insert into tblEmployee values (5,'Sara', 3200, 'Female', 1)
Insert into tblEmployee values (6,'Ben', 4800, 'Male', 3)

Create View vWEmployeeDetails
@Gender nvarchar(20)
as
Select Id, Name, Gender, DepartmentId
from  tblEmployee
where Gender = @Gender

Create function fnEmployeeDetails(@Gender nvarchar(20))
Returns Table
as
Return 
(Select Id, Name, Gender, DepartmentId
from tblEmployee where Gender = @Gender)

Select * from dbo.fnEmployeeDetails('Male')

Create View vWEmployeeDetailsSorted
as
Select Id, Name, Gender, DepartmentId
from tblEmployee
order by Id

Create Table ##TestTempTable(Id int, Name nvarchar(20), Gender nvarchar(10))

Insert into ##TestTempTable values(101, 'Martin', 'Male')
Insert into ##TestTempTable values(102, 'Joe', 'Female')
Insert into ##TestTempTable values(103, 'Pam', 'Female')
Insert into ##TestTempTable values(104, 'James', 'Male')

Create View vwOnTempTable
as
Select Id, Name, Gender
from ##TestTempTable


