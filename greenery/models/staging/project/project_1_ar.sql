{{
    config(
        MATERIALIZED = 'table'
    )
}}

with users as (
    select * from {{ ref('stg_users')}}
)

select * from users limit 10