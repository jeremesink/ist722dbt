with fm as (
    select
        'Fudgemart' as source_system,
        cast(o.order_id as varchar) as source_order_id,
        cast(o.customer_id as varchar) as source_customer_id,
        cast(od.product_id as varchar) as source_item_id,
        o.order_date,
        o.shipped_date,
        null as returned_date,
        od.order_qty as quantity,
        p.product_retail_price as unit_price,
        'Shipping' as fulfillment_channel
    from {{ ref('stg_fm_orders') }} o
    join {{ ref('stg_fm_order_details') }} od using (order_id)
    join {{ ref('stg_fm_products') }} p using (product_id)
),

ff as (
    select
        'FudgeFlix' as source_system,
        cast(at.at_id as varchar) as source_order_id,
        cast(at.at_account_id as varchar) as source_customer_id,
        cast(at.at_title_id as varchar) as source_item_id,
        at.order_date,
        at.shipped_date,
        at.returned_date,
        1 as quantity,
        pl.plan_price as unit_price,
        case
            when at.shipped_date is not null then 'Rental'
            when t.title_instant_available = true then 'Streaming'
            else 'Unknown'
        end as fulfillment_channel
    from {{ ref('stg_ff_account_titles') }} at
    join {{ ref('stg_ff_accounts') }} a on a.account_id = at.at_account_id
    join {{ ref('stg_ff_titles') }} t on t.title_id = at.at_title_id
    join {{ ref('stg_ff_plans') }} pl on pl.plan_id = a.account_plan_id
)

select * from fm
union all
select * from ff;
