
  
  create or replace view FAWDBTCORE.mobile_users_names as
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
    select start_users_cleaned.name
    from start_users_cleaned
    join start_mobile_events_cleaned on start_mobile_events_cleaned.user_id = start_users_cleaned.user_id
)

select * from mobile_users_names

