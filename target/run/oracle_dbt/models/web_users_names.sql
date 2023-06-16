
  
  create or replace view FAWDBTCORE.web_users_names as
    with start_web_events_cleaned as (

    select * from FAWDBTCORE.stg_web_events
),

start_mobile_events_cleaned as (

    select * from FAWDBTCORE.stg_mobile_events
), 

start_users_cleaned as (

    select * from FAWDBTCORE.stg_users
),

web_users_names as (
      SELECT u.name, w.most_frequent_browser
FROM start_users_cleaned u
JOIN (
  SELECT w.user_id, w.browser AS most_frequent_browser
  FROM (
    SELECT user_id, browser, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY COUNT(*) DESC) AS rn
    FROM start_web_events_cleaned
    GROUP BY user_id, browser
  ) w
  WHERE rn = 1
) w ON u.user_id = w.user_id
)

select * from web_users_names

