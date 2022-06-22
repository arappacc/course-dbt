{{
    config(
        MATERIALIZED='view'
    )
}}

with users as (
    select *
    from {{ref('stg_users')}}
)

SELECT
user_id,
first_name,
last_name,
first_name || ' ' || last_name as full_name,
email,
phone_number,
address_id,
created_at,
updated_at
FROM users