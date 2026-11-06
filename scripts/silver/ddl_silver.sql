/*
================================================================================================

DDL SCRIPTS : CREATING SILVER TABLES

================================================================================================

** SCRIPT PURPOSE : **
          This script creates tables in the 'Silver' schema, dropping existing table if they
          already exists.
          Run this script to re_define the DDl structure of 'Silver' table
  
================================================================================================
*/
-- creating Silver layer table for different source of data
-- source crm
-- customer_info.csv
if object_id('Silver.crm_cust_info','U') is not null 
drop table Silver.crm_cust_info

CREATE TABLE Silver.crm_cust_info (
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date date,
dwh_create_date datetime2 default getdate()
);

-- prd_info.csv
if object_id('Silver.crm_prd_info','U') is not null 
drop table Silver.crm_prd_info

CREATE TABLE Silver.crm_prd_info (
prd_id int,
cat_id nvarchar(50),
prd_key nvarchar(50),
prd_nm nvarchar(70),
prd_cost int,
prd_line nvarchar(70),
prd_start_dt date,
prd_end_dt date,
dwh_create_date datetime2 default getdate()
);

-- sales_details.csv
if object_id('Silver.crm_sales_details','U') is not null 
drop table Silver.crm_sales_details

CREATE TABLE Silver.crm_sales_details (
sls_ord_num nvarchar(70),
sls_prd_key nvarchar(70),
sls_cust_id int,
sls_order_dt date,
sls_ship_dt date,
sls_due_dt date,
sls_sales int,
sls_quantity int,
sls_price int,
dwh_create_date datetime2 default getdate()
);


-- source erp
-- CUST_AZ12.csv
if object_id('Silver.erp_cust_az12','U') is not null 
drop table Silver.erp_cust_az12

CREATE TABLE Silver.erp_cust_az12 (
cid NVARCHAR(70),
bdate DATE,
gen NVARCHAR(10),
dwh_create_date datetime2 default getdate()
);

--LOC_A101
if object_id('Silver.erp_loc_a101','U') is not null 
drop table Silver.erp_loc_a101

CREATE TABLE Silver.erp_loc_a101 (
cid NVARCHAR(70),
cntry VARCHAR(100),
dwh_create_date datetime2 default getdate()
);

-- PX_CAT_G1V2
if object_id('Silver.erp_px_cat_g1v2','U') is not null 
drop table Silver.erp_px_cat_g1v2

CREATE TABLE Silver.erp_px_cat_g1v2 (
id NVARCHAR (100),
cat NVARCHAR (100),
subcat NVARCHAR (100),
maintainence VARCHAR (50),
dwh_create_date datetime2 default getdate()
);


