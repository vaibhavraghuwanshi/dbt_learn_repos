{{config(materialized='view', 
        secure=true,
        database='SNOWFLAKE_DT',
        schema='PUBLIC',
        )}}

select
o.id,
o.customer_id,
o.order_date,
o.amount,
c.first_name,
c.last_name,
c.email
from snowflake_dt.public.raw_customers c
join snowflake_dt.public.raw_orders o
on c.id = o.customer_id