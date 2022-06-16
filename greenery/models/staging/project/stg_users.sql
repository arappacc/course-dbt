{{
  config(
    materialized='table'
  )
}}

with src_greenery_users as (
  SELECT * FROM {{ source('src_greenery', 'users') }}
),

final as (
  SELECT 
      user_id,
      first_name,
      last_name,
      email,
      phone_number,
      created_at,
      updated_at,
      address_id

  FROM src_greenery_users
)

select * from final

