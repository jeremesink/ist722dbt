select
    order_id,
    product_id,
    order_qty
from {{ source('fudgemart', 'fm_order_details') }}
