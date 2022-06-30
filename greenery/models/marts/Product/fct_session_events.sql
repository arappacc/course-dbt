{{
    config(
        MATERIALIZED='table'
    )
}}

-- setting macro to separate event types
{% set events = dbt_utils.get_column_values(
    table=ref('stg_events'), 
    column='event_type') %}

with all_info as (
    SELECT 
    session_id,
    user_id, 
    product_id
    {% for event_type in events %},
    {{aggregate_events(event_type)}} as {{event_type}}
    {% endfor %}    

    FROM {{ ref('stg_events') }}
    group by session_id, user_id, product_id
)

select * from all_info