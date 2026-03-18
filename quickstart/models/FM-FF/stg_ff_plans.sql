select
    plan_id,
    plan_price
from {{ source('fudgeflix', 'ff_plans') }}
