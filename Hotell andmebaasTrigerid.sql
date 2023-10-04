CREATE TRIGGER markusAlterTabel
ON DATABASE
FOR ALTER_TABLE
AS
BEGIN
    PRINT 'Tabeli struktuur on muutunud';
END;

CREATE TABLE SampleTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);
ALTER TABLE SampleTable
ADD NEWColumn INT;

CREATE TRIGGER markusDropTabel
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    PRINT 'Tabeli on kustutatud';
END;

DROP TABLE SampleTable;


--next task


CREATE TABLE AuditTable
(
    AuditRecordID INT IDENTITY(1, 1) ,
    EventType VARCHAR(128) ,
    PostTime VARCHAR(128) ,
    SPID INT ,
    UserName VARCHAR(128) ,
    DatabaseName VARCHAR(128) ,
    SchemaName VARCHAR(128) ,
    ObjectName VARCHAR(128) ,
    ObjectType VARCHAR(128) ,
    Parameters VARCHAR(2000) ,
    AlterTableActionList VARCHAR(2000) ,
    TSQLCommand VARCHAR(2000)
);

CREATE OR ALTER TRIGGER TR_Schema_Change ON DATABASE 
FOR DDL_TABLE_VIEW_EVENTS
AS
 
DECLARE @EventData XML;  
SET @EventData = EVENTDATA();  
 
INSERT INTO dbo.AuditTable ( EventType ,
                             PostTime ,
                             SPID ,
                             UserName ,
                             DatabaseName ,
                             SchemaName ,
                             ObjectName ,
                             ObjectType ,
                             Parameters ,
                             AlterTableActionList ,
                             TSQLCommand )
 VALUES (@EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'VARCHAR(128)') ,
         @EventData.value('(/EVENT_INSTANCE/PostTime)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/SPID)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/UserName)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'VARCHAR(128)') ,
         @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'VARCHAR(128)') ,
         @EventData.value('(/EVENT_INSTANCE/ObjectType)[1]', 'VARCHAR(128)') ,
         @EventData.value('(/EVENT_INSTANCE/Parameters)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/AlterTableActionList)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)') 
      );
GO

CREATE TABLE t1(a INT)
ALTER TABLE t1 ADD b INT 
DROP TABLE t1
SELECT * FROM dbo.AuditTable

SELECT QUOTENAME(OBJECT_SCHEMA_NAME(TR.object_id)) + '.' + QUOTENAME(TR.name) [Trigger_name],
       QUOTENAME(OBJECT_SCHEMA_NAME(T.object_id)) + '.' + QUOTENAME(T.name) [Parent_table_name],                 
       QUOTENAME(OBJECT_SCHEMA_NAME(V.object_id)) + '.' + QUOTENAME(V.name) [Parent_view_name]
FROM sys.triggers TR
LEFT JOIN sys.tables T
    ON TR.parent_id = T.object_id
LEFT JOIN sys.views V
    ON TR.parent_id = V.object_id
WHERE TR.parent_class = 1

SELECT name,
       parent_class_desc,
       type_desc,
       is_disabled
FROM sys.triggers
WHERE is_disabled = 0;

SELECT 
	t2.[name] TableTriggerReference
	, SCHEMA_NAME(t2.[schema_id]) TableSchemaName
	, t1.[name] TriggerName
FROM sys.triggers t1
	INNER JOIN sys.tables t2 ON t2.object_id = t1.parent_id
WHERE t1.is_disabled = 0
	AND t1.is_ms_shipped = 0
	AND t1.parent_class = 1


--next task

CREATE TABLE #triggers
(
  [database]          sysname,
  [schema]            sysname,
  [object]            sysname,
  name                sysname,
  is_disabled         bit,
  definition          nvarchar(max)
);	

USE AdventureWorksDW2016; -- for example
GO
INSERT #triggers
(
  [database],
  [schema],
  [object],
  name,
  is_disabled,
  definition
)
SELECT
  DB_NAME(), 
  s.name, 
  o.name, 
  t.name, 
  t.is_disabled, 
  m.definition
FROM sys.triggers AS t
INNER JOIN sys.sql_modules AS m
  ON t.object_id = m.object_id
INNER JOIN sys.objects AS o
  ON t.parent_id = o.object_id
INNER JOIN sys.schemas AS s
  ON o.schema_id = s.schema_id
WHERE parent_class = 1; -- OBJECT_OR_COLUMN	

DECLARE @db sysname = N'AdventureWorks';
DECLARE @sql  nvarchar(max) = N'',
        @exec nvarchar(max) = QUOTENAME(@db) + N'.sys.sp_executesql ';
SELECT @sql += N'DISABLE TRIGGER ' 
  + QUOTENAME([schema]) + N'.' + QUOTENAME([name]) + N' ON '  
  + QUOTENAME([schema]) + N'.' + QUOTENAME([object]) + N';'
FROM #triggers
WHERE is_disabled = 0
AND [database] = @db;
PRINT @sql;
-- EXEC @exec @sql;	

DECLARE @db sysname = N'AdventureWorks';
DECLARE @sql  nvarchar(max) = N'',
        @exec nvarchar(max) = QUOTENAME(@db) + N'.sys.sp_executesql ';
SELECT @sql += N'ENABLE TRIGGER ' 
  + QUOTENAME([schema]) + N'.' + QUOTENAME([name]) + N' ON '  
  + QUOTENAME([schema]) + N'.' + QUOTENAME([object]) + N';'
FROM #triggers
WHERE is_disabled = 0
AND [database] = @db;
PRINT @sql;
-- EXEC @exec @sql;	

DECLARE @db sysname = N'AdventureWorks';
DECLARE @sql  nvarchar(max) = N'',
        @exec nvarchar(max) = QUOTENAME(@db) + N'.sys.sp_executesql ';
SELECT @sql += N'DROP TRIGGER ' 
  + QUOTENAME([schema]) + N'.' + QUOTENAME([name]) + N';'
FROM #triggers
WHERE is_disabled = 0
AND [database] = @db;
PRINT @sql;
-- EXEC @exec @sql;

DECLARE @db sysname = N'AdventureWorks';
DECLARE @sql  nvarchar(max) = N'',
        @exec nvarchar(max) = QUOTENAME(@db) + N'.sys.sp_executesql ';
SELECT @sql += definition + CHAR(13) + CHAR(10) + N'GO' + CHAR(13) + CHAR(10)
  FROM #triggers;

SELECT @sql += N'DISABLE TRIGGER ' 
  + QUOTENAME([schema]) + N'.' + QUOTENAME([name]) + N' ON '  
  + QUOTENAME([schema]) + N'.' + QUOTENAME([object]) + N';'
FROM #triggers
WHERE is_disabled = 1  /***** important switch here *****/
AND [database] = @db;
PRINT @sql;
-- EXEC @exec @sql;	

