with f as (
    select
        source_order_id as fulfillment_id,
        source_customer_id as customer_key,
        source_item_id as item_key,
        source_order_id as order_key,

        -- convert timestamps to YYYYMMDD integers
        to_number(to_char(to_date(order_date), 'YYYYMMDD')) as order_date_key,
        to_number(to_char(to_date(shipped_date), 'YYYYMMDD')) as shipped_date_key,
        to_number(to_char(to_date(returned_date), 'YYYYMMDD')) as returned_date_key,


        quantity,
        unit_price,
        quantity * unit_price as extended_price,
        fulfillment_channel,
        source_system
    from {{ ref('stg_fulfillment_events') }}
    qualify row_number() over (partition by source_system order by order_date) <= 5
)

select * from f
order by source_system, fulfillment_id
