with stg_orders as (

    select
        orderid,
        {{ dbt_utils.generate_surrogate_key(["customerid"]) }} as customerkey,
        {{ dbt_utils.generate_surrogate_key(["employeeid"]) }} as employeekey,
        to_number(to_char(try_to_date(orderdate), 'YYYYMMDD')) as orderdatekey
    from {{ source('northwind','Orders') }}

),

stg_order_details as (

    select
        orderid,
        productid,
        quantity,
        unitprice,
        discount,

        -- additive facts
        (quantity * unitprice) as extendedpriceamount,
        (quantity * unitprice * discount) as discountamount,
        (quantity * unitprice * (1 - discount)) as soldamount
    from {{ source('northwind','Order_Details') }}

),

stg_products as (

    select
        productid,
        {{ dbt_utils.generate_surrogate_key(["productid"]) }} as productkey
    from {{ source('northwind','Products') }}

)

select
    -- degenerate dimension
    od.orderid,

    -- dimension keys
    o.customerkey,
    o.employeekey,
    o.orderdatekey,
    p.productkey,

    -- additive facts
    od.quantity,
    od.extendedpriceamount,
    od.discountamount,
    od.soldamount

from stg_order_details od
join stg_orders o
    on od.orderid = o.orderid
join stg_products p
    on od.productid = p.productid

