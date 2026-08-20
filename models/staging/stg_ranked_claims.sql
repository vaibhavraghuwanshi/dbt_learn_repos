{{
  config(
    materialized = 'view',
    schema = 'STAGING',
    )
}}

with ranked_claims as (
    select claim_id,
           employee_id,
           claim_date,
           upper(expense_type) as expense_type,
           claimed_amount,
           currency,
           lower(approval_status) as approval_status,
           approver_id,
           row_number() over (partition by claim_id order by claim_date desc) as rn
           from raw.public.expense_claims
)

select claim_id,
       employee_id,
       claim_date,
       expense_type,
       claimed_amount,
       currency,
       approval_status,
       approver_id
       from ranked_claims
       where rn = 1