--92 DDL Trigger SQL Server

-- Loo DDL-triger, mis jälgib andmebaasisiseseid CREATE_TABLE sündmusi.
create trigger trMyNotFirstTrigger
on database
for CREATE_TABLE
as
begin
    print 'Uus tabel loodud'
end

-- Muuda olemasolevat trigerit, et see reageeriks ka ALTER_TABLE ja DROP_TABLE sündmustele.
alter trigger trMyNotFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
    print 'Tabelit on just loodud, muudetud või kustutatud'
end

DROP TABLE Test;

-- Muuda trigerit, et see takistaks tabelite loomist, muutmist või kustutamist.
alter trigger trMyNotFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
    rollback
    print 'Sa ei saa luua, muuta ega kustutada tabelit'
end

disable trigger trMyNotFirstTrigger on database

--93 Server-Scoped DDL triggerid
	
-- Loo andmebaasi ja serveri tasandi trigerid, mis reageerivad CREATE_TABLE, ALTER_TABLE ja DROP_TABLE sündmustele.
create trigger tr_DatabaseScopeTrigger
on database
for create_table, alter_table, drop_table
as
begin
    rollback
    print 'Sa ei saa luua, muuta ega kustutada tabelit selles andmebaasis'
end

Create table Test (Id int)

-- Loo serveri tasandi triger, mis takistab tabelite loomist, muutmist või kustutamist serveri kõigis andmebaasides.
create trigger tr_ServerScopeTrigger
on all server
for create_table, alter_table, drop_table
as
begin
    rollback
    print 'Sa ei saa luua, muuta ega kustutada tabelit üheski andmebaasis serveris'
end

Create table Test (Id int)

disable trigger tr_ServerScopeTrigger on all server

Create table Test (Id int)

disable trigger trMyNotFirstTrigger on database;
disable trigger tr_DatabaseScopeTrigger on  database;

enable trigger tr_ServerScopeTrigger on all server

drop table Test

Create table Test (Id int)

drop trigger tr_ServerScopeTrigger on all server

--94 SQL Serveri trigerite täitmise järjekord
	
-- Määra trigerite täitmise järjekord tabeli loomisel andmebaasis.
exec sp_settriggerorder
@triggername = 'tr_DatabaseScopeTrigger',
@order = 'none',
@stmttype = 'create_table',
@namespace = 'database'

EXEC sp_helptrigger 'Test';

--96 Logon trigger SQL Serveris

-- Loo logon-triger, mis jälgib sisselogimissündmusi ja blokeerib liiga palju ühendusi.
create trigger tr_LogonAuditTriggers
on all server
for LOGON
as
begin
    declare @LoginName nvarchar(100)

    set @LoginName = ORIGINAL_LOGIN()

    if (select count(*) from sys.dm_exec_sessions
        where is_user_process=1
        and original_login_name = @LoginName) > 3
    begin
        print 'Neljas ühendus kasutajalt ' + @LoginName + ' on blokeeritud'
        rollback
    end
end

drop trigger tr_LogonAuditTriggers on all server

Execute sp_readerrorlog
