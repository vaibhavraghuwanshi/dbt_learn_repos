

with base as (
    select *
    from {{ ref('stg_ranked_claims') }}
),
dq_check as (
    select *,
    case when {{ check_null_conditions(['claim_id', 'employee_id', 'claimed_amount']) }} 
    then 'Fail' else 'Pass' end as dq_status,
    case when claimed_amount >10000 AND expense_type in ('TRAVEL','HOTEL') then 'Violation' 
        else 'Ok' end as policy_violation_flag
    from base
)

select claim_id,
 employee_id,
 claim_date,
 expense_type,
 claimed_amount,currency,
 approval_status,approver_id,dq_status,policy_violation_flag
from dq_check
where dq_status = 'Pass'