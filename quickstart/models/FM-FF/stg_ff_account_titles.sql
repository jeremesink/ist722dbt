select
    AT_ID,
    AT_ACCOUNT_ID,
    AT_TITLE_ID,

    -- Convert epoch-microseconds → seconds → timestamp
    try_to_timestamp_ntz(floor(AT_QUEUE_DATE / 1e6))      as order_date,
    try_to_timestamp_ntz(floor(AT_SHIPPED_DATE / 1e6))    as shipped_date,
    try_to_timestamp_ntz(floor(AT_RETURNED_DATE / 1e6))   as returned_date,

    -- keep the rest of the raw fields if needed
    AT_RATING
from {{ source('fudgeflix', 'ff_account_titles') }};

