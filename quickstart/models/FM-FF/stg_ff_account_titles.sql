select
    at_id,
    at_account_id,
    at_title_id,
    try_to_timestamp_ntz(at.at_queue_date / 1e6) as order_date,
    try_to_timestamp_ntz(at.at_shipped_date / 1e6) as shipped_date,
    try_to_timestamp_ntz(at.at_returned_date / 1e6) as returned_date,

from {{ source('fudgeflix', 'ff_account_titles') }}
