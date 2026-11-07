/*
================================================================================================

DDL SCRIPTS : CREATING GOLD VIEWS

================================================================================================

** SCRIPT PURPOSE : **
          This script creates views in the 'Gold' schema, dropping existing views if they
          already exists.
		  The Gold layer represents the final dimension and fact tables (star schema)

		  Each view performs transformations and combines data from the Silver layer to produce a clean,
		  enriched and business ready dataset 
          
Usage :
      - These views can be queried directly for analytics and reporting
  
================================================================================================
*/

-- creating views for sales for gold layer
-- ==================================================================================
-- Create Facts : gold.fact_sales
-- ==================================================================================
if object_id ('gold.fact_sales','V') is not null 
drop view gold.fact_sales

go

create view gold.fact_sales as
(
select 
sd.sls_ord_num as order_number,
pr.product_key,
cs.customer_key,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as ship_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales_amount,
sd.sls_quantity as quantity,
sd.sls_price as price
from silver.crm_sales_details sd
left join gold.dim_products pr
on sd.sls_prd_key = pr.product_number
left join gold.dim_customers cs
on sd.sls_cust_id = cs.customer_id
)
go

-- ==================================================================================
-- Create Dimension : gold.dim_customers
-- ==================================================================================
if object_id ('gold.dim_customers','V') is not null 
drop view gold.dim_customers

go

create view gold.dim_customers as 
(
SELECT 
	row_number () over (order by cst_id asc) as customer_key,
	ci.cst_id as customer_id,
	ci.cst_key as customer_number,
	ci.cst_firstname as first_name,
	ci.cst_lastname as last_name,
	la.cntry as country,
	ci.cst_marital_status as marital_status,
	case 
	when ci.cst_gndr ='n/a' then coalesce (ca.gen,'n/a')
	else ci.cst_gndr -- crm is the master for gender info
	end gender,
	ca.bdate as birthdate,
	ci.cst_create_date as create_date

FROM SILVER.crm_cust_info as ci
left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key = la.cid
)
go

--=====================================================================================================
-- ==================================================================================
-- Create Dimension : gold.dim_products
-- ==================================================================================
if object_id ('gold.dim_products','V') is not null 
drop view gold.dim_products

go

create view gold.dim_products as 
(
select 
ROW_NUMBER () over(order by pin.prd_start_dt,pin.prd_key) as product_key,
pin.prd_id as product_id,
pin.prd_key as product_number,
pin.prd_nm as product_name,
pin.cat_id as category_id,
pc.cat as category_name,
pc.subcat as subcategory,
pc.maintainence as maintainence,
pin.prd_cost as cost,
pin.prd_line as product_line,
pin.prd_start_dt as startdate
from silver.crm_prd_info pin
left join silver.erp_px_cat_g1v2 as pc
on pin.cat_id = pc.id
where pin.prd_end_dt is null -- filtering out old historical data
)

go



