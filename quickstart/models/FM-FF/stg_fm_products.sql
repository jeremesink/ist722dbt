select
    product_id,
    try_to_number(regexp_replace(product_retail_price, '[^0-9.]', '')) as product_retail_price
from {{ source('fudgemart', 'fm_products') }}
