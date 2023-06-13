with start_web_events_cleaned as (

    select * from {{ ref('stg_web_events') }}
),

start_mobile_events_cleaned as (

    select * from {{ ref('stg_mobile_events') }}
), 

start_users_cleaned as (

    select * from {{ ref('stg_users') }}
),

web_users_names as (
    select start_users_cleaned.name
    from start_users_cleaned
    join start_web_events_cleaned on start_web_events_cleaned.user_id = start_users_cleaned.user_id
)

select * from web_users_names