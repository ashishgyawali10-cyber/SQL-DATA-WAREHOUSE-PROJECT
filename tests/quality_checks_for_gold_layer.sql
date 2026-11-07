/*
================================================================================================================================
QUALITY CHECKS
================================================================================================================================
Script Purpose :
	This script performs quality checks to validate the integrity, consistenct, and accuracy of the Gold layer. 
	These check insure
	-Uniqueness of surrogate keys in dimension tables.
	- Referential integrity between fact and dimension tables.
	- Validation of relationship in the data model for analytical purpose.

Usage notes:
	- Run these checks after data loading silver layer.
	- Investigate and resolve any discrepancies found during the checks

*/

-- test for gold layer
-- test for gender from both table where cst_gndr <> gen

SELECT distinct
	ci.cst_gndr,
	ca.gen,
	case 
	when ci.cst_gndr ='n/a' then coalesce (ca.gen,'n/a')
	else ci.cst_gndr -- crm is the master for gender info
	end gender
FROM SILVER.crm_cust_info as ci
left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
order by 1,2

-- quality check for gold.dim_customers
select distinct gender
from gold.dim_customers

-- test for products
-- creating view for product information 
select prd_key, count(*)
from (
select 
pin.prd_id,
pin.cat_id,
pin.prd_key,
pin.prd_nm,
pin.prd_cost,
pin.prd_line,
pin.prd_start_dt,
pc.cat,
pc.subcat,
pc.maintainence
from silver.crm_prd_info pin
left join silver.erp_px_cat_g1v2 as pc
on pin.cat_id = pc.id
where pin.prd_end_dt is null -- filtering out old historical data
)t 
group by prd_key
having count(*)>1 -- no duplicates in prd_key which makes it possible to join with sales


-- foreign key integrity (dimension)
select * from gold.fact_sales as s
left join gold.dim_customers cs
on cs.customer_key = s.customer_key
left join gold.dim_products p
on p.product_key = s.product_key
where s.product_key is null
or cs.customer_key is null
