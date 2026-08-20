{{config(materialized='dynamic_table', 
        snowflake_warehouse='COMPUTE_WH',
        database='SNOWFLAKE_DT',
        schema='TRANSFORM_DT',
        target_lag = 'DOWNSTREAM'
        )}}

with customer_dt as (
    select cust_id,
           cust_name,
           total_outstanding_amt,
           crid,
           location,
           cust_created
           from snowflake_dt.public.customer
           qualify row_number() over (partition by cust_id order by cust_created desc) = 1
          
)

select * from customer_dt