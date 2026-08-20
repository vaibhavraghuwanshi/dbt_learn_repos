{{config(materialized='table'
        
        )}}

select o.id,
o.customer_id,
o.order_date,
o.amount,
c.first_name,
c.last_name,c.email
from
{{source('ecommerce', 'raw_customers')}} c
join {{ source('ecommerce', 'raw_orders') }} o
on o.customer_id = c.id

