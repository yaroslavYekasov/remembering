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
