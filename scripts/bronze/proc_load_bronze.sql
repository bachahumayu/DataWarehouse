-- Active: 1770798963325@@127.0.0.1@5432@data_warehouse@bronze
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
-- =========================================
-- Bronze Layer Load (CSV -> Bronze Tables)
-- =========================================
-- Note:
-- Uses \copy to load CSVs client-side (no server permissions needed)
-- Run this in psql or VS Code SQL Tools terminal
-- =========================================


TRUNCATE TABLE bronze.crm_cust_info;
\copy bronze.crm_cust_info(cst_id, cst_key, cst_firstname, cst_lastname, cst_marital_status, cst_gndr, cst_create_date) FROM '/home/humayu/data_warehouse/datasets/source_crm/cust_info.csv' DELIMITER ',' CSV HEADER;
SELECT 'crm_cust_info rows:' AS table_name, COUNT(*) AS row_count FROM bronze.crm_cust_info;

-- crm_prd_info
TRUNCATE TABLE bronze.crm_prd_info;
\copy bronze.crm_prd_info(prd_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt) FROM '/home/humayu/data_warehouse/datasets/source_crm/prd_info.csv' DELIMITER ',' CSV HEADER;
SELECT 'crm_prd_info rows:' AS table_name, COUNT(*) AS row_count FROM bronze.crm_prd_info;

-- crm_sales_details
TRUNCATE TABLE bronze.crm_sales_details;
\copy bronze.crm_sales_details(sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price) FROM '/home/humayu/data_warehouse/datasets/source_crm/sales_details.csv' DELIMITER ',' CSV HEADER;
SELECT 'crm_sales_details rows:' AS table_name, COUNT(*) AS row_count FROM bronze.crm_sales_details;


-- ==========================================================
-- ERP Tables
-- ==========================================================

-- erp_loc_a101
TRUNCATE TABLE bronze.erp_loc_a101;
\copy bronze.erp_loc_a101(cid, cntry) FROM '/home/humayu/data_warehouse/datasets/source_erp/LOC_A101.csv' DELIMITER ',' CSV HEADER;
SELECT 'erp_loc_a101 rows:' AS table_name, COUNT(*) AS row_count FROM bronze.erp_loc_a101;

-- erp_cust_az12
TRUNCATE TABLE bronze.erp_cust_az12;
\copy bronze.erp_cust_az12(cid, bdate, gen) FROM '/home/humayu/data_warehouse/datasets/source_erp/CUST_AZ12.csv' DELIMITER ',' CSV HEADER;
SELECT 'erp_cust_az12 rows:' AS table_name, COUNT(*) AS row_count FROM bronze.erp_cust_az12;

-- erp_px_cat_g1v2
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
\copy bronze.erp_px_cat_g1v2(id, cat, subcat, maintenance) FROM '/home/humayu/data_warehouse/datasets/source_erp/PX_CAT_G1V2.csv' DELIMITER ',' CSV HEADER;
SELECT 'erp_px_cat_g1v2 rows:' AS table_name, COUNT(*) AS row_count FROM bronze.erp_px_cat_g1v2;


-- ==========================================================
-- Bronze Layer Load Completed
-- ==========================================================
SELECT 'Bronze Layer Loading Completed' AS status;
