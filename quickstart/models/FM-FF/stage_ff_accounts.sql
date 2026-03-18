select
    account_id,
    account_plan_id
from {{ source('fudgeflix', 'ff_accounts') }}
