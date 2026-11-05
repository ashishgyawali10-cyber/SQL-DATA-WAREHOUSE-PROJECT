/*
=================================================================================
Create Database and Schemas
=================================================================================
Script purpose :
	This script creates a new database named 'DATAWAREHOUSE' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three
	schemas within the database ie bronze,silver and gold.


WARNING :
	Running this script will drop the entire 'DATAWAREHOUSE' database if it exists.
	All data in the database will be permanently deleted. proceeds with caution and ensure you have proper
	backups before running this script.
	*/

-- Create Database 'DataWarehouse'
use master;
GO 

-- Drop and recreate the 'DATAWAREHOUSE' database
if exists (select 1 from sys.databases where name = 'DATAWAREHOUSE')
BEGIN
	ALTER DATABASE DATAWAREHOUSE SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DATAWAREHOUSE;
END;
GO

-- CREATE THE 'DATAWAREHOUSE' DATABASE
CREATE DATABASE DATAWAREHOUSE;
GO
USE DATAWAREHOUSE;
GO


-- CREATE SCHEMAS
CREATE SCHEMA Bronze;
go
CREATE SCHEMA Silver;
go
CREATE SCHEMA Gold;
GO
