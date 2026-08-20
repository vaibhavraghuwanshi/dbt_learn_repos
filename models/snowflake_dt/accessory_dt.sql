{{config(materialized='dynamic_table', 
        snowflake_warehouse='COMPUTE_WH',
        database='SNOWFLAKE_DT',
        schema='TRANSFORM_DT',
        target_lag = 'DOWNSTREAM'
        )}}


WITH accessory_dt AS (
    SELECT a.cust_id,
           a.acc_id,
           a.acc_category,
           a.acc_status,
           a.acc_price,
           a.acc_count
    FROM SNOWFLAKE_DT.PUBLIC.Accessory_item a
    QUALIFY ROW_NUMBER() OVER (PARTITION BY a.cust_id, a.acc_id ORDER BY a.acc_price DESC) = 1
)
SELECT * FROM accessory_dt