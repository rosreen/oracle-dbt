


with web_events_extracted as (

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
  created_at
    FROM FAWDBTCORE.web_events
),

web_events_cleaned as (
    SELECT DISTINCT *
    FROM web_events_extracted
)

select * from web_events_cleaned



  -- this filter will only be applied on an incremental run
where created_at >= (select max(created_at) from FAWDBTCORE.stg_web_events)

