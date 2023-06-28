with start_web_events_cleaned as (

    select * from FAWDBTCORE.stg_web_events
),

start_mobile_events_cleaned as (

    select * from FAWDBTCORE.stg_mobile_events
), 

start_users_cleaned as (

    select * from FAWDBTCORE.stg_users
),

mobile_users_names as (
    select start_users_cleaned.name, count(start_mobile_events_cleaned.event_id) as num_mobile_events
    from start_users_cleaned
    join start_mobile_events_cleaned on start_mobile_events_cleaned.user_id = start_users_cleaned.user_id
    group by start_users_cleaned.name
    ORDER BY num_mobile_events DESC
)

select * from mobile_users_names