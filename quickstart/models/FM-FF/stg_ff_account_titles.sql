select 
    AT_ID,
    AT_ACCOUNT_ID,
    AT_TITLE_ID,
    to_timestamp_ntz(try_to_number(AT_QUEUE_DATE) / 1000000) as order_date,
    to_timestamp_ntz(try_to_number(AT_SHIPPED_DATE) / 1000000) as shipped_date,
    to_timestamp_ntz(try_to_number(AT_RETURNED_DATE) / 1000000) as returned_date
from {{ source ('fudgeflix_v3', 'ff_account_titles') }}