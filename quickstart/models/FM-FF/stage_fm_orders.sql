select
    order_id,
    customer_id,
    to_timestamp(order_date/1000000) as order_date,
    to_timestamp(shipped_date/1000000) as shipped_date
from {{ source('fudgemart', 'fm_orders') }}
