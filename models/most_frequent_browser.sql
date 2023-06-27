

with start_web_events_cleaned as (

    select * from {{ ref('stg_web_events') }}
),

start_mobile_events_cleaned as (

    select * from {{ ref('stg_mobile_events') }}
), 

start_users_cleaned as (

    select * from {{ ref('stg_users') }}
),

most_frequent_broswer as (
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

select * from most_frequent_broswer 
