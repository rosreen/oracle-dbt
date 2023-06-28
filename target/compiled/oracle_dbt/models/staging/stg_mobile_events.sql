


with mobile_events_extracted as (

 SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  app_name,
  operating_system,
  country,
  duration_seconds,
  conversion_status,
  created_at
FROM FAWDBTCORE.mobile_events
),

mobile_events_cleaned as (
    SELECT DISTINCT *
    FROM mobile_events_extracted
)

select * from mobile_events_cleaned





  -- this filter will only be applied on an incremental run
where created_at >= (select max(created_at) from FAWDBTCORE.stg_mobile_events)

