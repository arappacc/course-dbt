{{
    config(
        MATERIALIZED='view'
    )
}}

WITH items_per_order as (
    SELECT
    order_id, 
    count (product_id) as num_products
    FROM {{ref('stg_order_items')}}
    GROUP BY order_id
)

SELECT
o.order_id,
o.user_id,
o.created_at,
o.order_cost,
ipo.num_products,
o.status,
o.delivered_at
FROM {{ref('stg_orders')}} o 
left join items_per_order ipo
on o.order_id = ipo.order_id