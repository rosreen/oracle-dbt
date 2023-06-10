with start_web_events_cleaned as (

    select * from FAWDBTCORE.stg_web_events
),

start_mobile_events_cleaned as (

    select * from FAWDBTCORE.stg_mobile_events
), 

start_users_cleaned as (

    select * from FAWDBTCORE.stg_users
), 

freq_web_users_ids as (
SELECT user_id, COUNT(*) AS frequency
FROM web_events_cleaned
GROUP BY user_id
ORDER BY frequency DESC
),

freq_mobile_user_ids as (
SELECT user_id, COUNT(*) AS frequency
FROM mobile_events_cleaned
GROUP BY user_id
ORDER BY frequency DESC
),

freq_web_user_names as (
SELECT u.name, COUNT(*) AS frequency
FROM freq_web_users_ids AS w
JOIN users_cleaned AS u ON u.user_id = w.user_id
GROUP BY u.user_id
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