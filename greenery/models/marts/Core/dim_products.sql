{{
    config(
        MATERIALIZED='view'
    )
}}

with products as (
    select *
    from {{ref('stg_products')}}
)

SELECT
    product_id,
    name,
    price,
    inventory
FROM products