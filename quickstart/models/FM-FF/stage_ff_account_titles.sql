select
    at_id,
    at_account_id,
    at_title_id,
    at_queue_date,
    at_shipped_date,
    at_returned_date
from {{ source('fudgeflix', 'ff_account_titles') }}
