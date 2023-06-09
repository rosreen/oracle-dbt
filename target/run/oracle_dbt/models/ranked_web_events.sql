
  
  create or replace view FAWDBTCORE.ranked_web_events as
    with start_ranked_web_events as (

    select * from FAWDBTCORE.stg_web_events

),

ranked_web_events as (

SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  page_url,
  browser,
  device_type,
  country,
  duration_seconds,
  conversion_status,
  RANK() OVER (PARTITION BY device_type ORDER BY duration_seconds DESC) AS duration_rank
FROM start_ranked_web_events

)

select * from ranked_web_events

