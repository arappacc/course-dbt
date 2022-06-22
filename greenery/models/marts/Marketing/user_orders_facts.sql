{{
    config(
        MATERIALIZED='view'
    )
}}

with user_demographics as (
    select 
        u.user_id,
        u.email,
        u.phone_number,
        a.state
    from {{ref('stg_users')}} u
    left join {{ref('stg_addresses')}} a on u.address_id = a.address_id
),

order_products as (

    select 
        oi.order_id,
        p.name as product_name,
        oi.quantity as product_quantity
    from {{ref('stg_order_items')}} oi
    left join {{ref('stg_products')}} p on oi.product_id = p.product_id

),

raw_final as (

    select 
        u.user_id,
        u.email as user_email,
        u.phone_number as user_phone,
        u.state as user_state,
        product_name,
        SUM(product_quantity) as total_purchased

    from user_demographics U
    left join {{ref('stg_orders')}} o on u.user_id = o.user_id
    left join order_products ou on ou.order_id = o.order_id
    group by u.user_id, user_email, user_phone, user_state, product_name

)

select * from raw_final