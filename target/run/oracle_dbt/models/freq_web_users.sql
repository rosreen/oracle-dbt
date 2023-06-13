
  
  create or replace view FAWDBTCORE.freq_web_users as
    with start_web_events_cleaned as (

    select * from FAWDBTCORE.stg_web_events
),

start_mobile_events_cleaned as (

    select * from FAWDBTCORE.stg_mobile_events
), 

freq_web_users as (

    select * from FAWDBTCORE.stg_users
)

select * from freq_web_users

