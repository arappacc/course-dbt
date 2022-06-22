{{
    config(
        MATERIALIZED='view'
    )
}}

with page_views as (

    SELECT
    *
    from {{ref('stg_events')}}
    where event_type = 'page_view'

)

select user_id,
created_at as view_date,
product_id
from page_views pv 