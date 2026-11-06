/*
================================================================================================

DDL SCRIPTS : CREATING BRONZE TABLES

================================================================================================

** SCRIPT PURPOSE : **
          This script creates tables in the 'bronze' schema, dropping existing table if they
          already exists.
          Run this script to re_define the DDl structure of 'bronze' table
  
================================================================================================
*/
-- creating bronze layer table for different source of data
-- source crm
-- customer_info.csv
if object_id('Bronze.crm_cust_info','U') is not null 
drop table Bronze.crm_cust_info

CREATE TABLE Bronze.crm_cust_info (
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date date
);

-- prd_info.csv
if object_id('Bronze.crm_prd_info','U') is not null 
drop table Bronze.crm_prd_info

CREATE TABLE Bronze.crm_prd_info (
prd_id int,
prd_key nvarchar(50),
prd_nm nvarchar(70),
prd_cost int,
prd_line nvarchar(70),
prd_start_dt datetime,
prd_end_dt datetime
);

-- sales_details.csv
if object_id('Bronze.crm_sales_details','U') is not null 
drop table Bronze.crm_sales_details

CREATE TABLE Bronze.crm_sales_details (
sls_ord_num nvarchar(70),
sls_prd_key nvarchar(70),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price int
);


-- source erp
-- CUST_AZ12.csv
if object_id('Bronze.erp_cust_az12','U') is not null 
drop table Bronze.erp_cust_az12

CREATE TABLE Bronze.erp_cust_az12 (
cid NVARCHAR(70),
bdate DATE,
gen NVARCHAR(10)
);

--LOC_A101
if object_id('Bronze.erp_loc_a101','U') is not null 
drop table Bronze.erp_loc_a101

CREATE TABLE Bronze.erp_loc_a101 (
cid NVARCHAR(70),
cntry VARCHAR(100)
);

-- PX_CAT_G1V2
if object_id('Bronze.erp_px_cat_g1v2','U') is not null 
drop table Bronze.erp_px_cat_g1v2

CREATE TABLE Bronze.erp_px_cat_g1v2 (
id NVARCHAR (100),
cat NVARCHAR (100),
subcat NVARCHAR (100),
maintainence VARCHAR (50)
);


