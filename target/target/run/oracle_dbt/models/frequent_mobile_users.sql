
  
  create or replace view FAWDBTCORE.frequent_mobile_users as
    with start_mobile_events_cleaned as (

    select * from FAWDBTCORE.stg_mobile_events
), 

start_users_cleaned as (

    select * from FAWDBTCORE.stg_users
),


freq_mobile_user_ids as (
SELECT user_id, COUNT(*) AS frequency
FROM mobile_events_cleaned
GROUP BY user_id
ORDER BY frequency DESC
),

freq_mobile_user_names as (
SELECT u.name, COUNT(*) AS frequency
FROM mobile_events_extracted AS m
JOIN users_cleaned AS u ON u.user_id = m.user_id
GROUP BY u.user_id
ORDER BY frequency DESC
)

select * from freq_mobile_user_names

