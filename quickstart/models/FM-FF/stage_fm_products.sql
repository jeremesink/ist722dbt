select
    product_id,
    product_retail_price
from {{ source('fudgemart', 'fm_products') }}
