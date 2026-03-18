select
    AT_ID,
    AT_ACCOUNT_ID,
    AT_TITLE_ID,

    to_timestamp_ntz(AT_QUEUE_DATE   / 1000000) as order_date,
    to_timestamp_ntz(AT_SHIPPED_DATE / 1000000) as shipped_date,
    to_timestamp_ntz(AT_RETURNED_DATE / 1000000) as returned_date

from {{ source('fudgeflix', 'ff_account_titles') }};
