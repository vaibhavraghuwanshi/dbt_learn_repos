{{config(materialized='dynamic_table', 
        snowflake_warehouse='COMPUTE_WH',
        database='SNOWFLAKE_DT',
        schema='TRANSFORM_DT',
        target_lag = '3 minutes'
        )}}

with cust_accessory_dt as (
    select c.cust_id,
           c.cust_name,
           c.crid,
           c.location,
           c.cust_created,
           a.acc_id,
           a.acc_category,
           a.acc_status,
           a.acc_price,
           a.acc_count,
           a.acc_price/a.acc_count as price_per_accessory
    from {{ ref('customer_dt') }} c
    join {{ ref('accessory_dt') }} a
    on c.cust_id = a.cust_id
)

select * from cust_accessory_dt