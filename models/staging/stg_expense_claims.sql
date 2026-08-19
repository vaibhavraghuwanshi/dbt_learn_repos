select claim_id,
employee_id,
claim_date,
upper(expense_type) as expense_type,
claimed_amount,
currency,
lower(approval_status) as approval_status,
approver_id
from expense_claims