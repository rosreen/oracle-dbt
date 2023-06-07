with start_web_events_cleaned as (

    select * from {{ ref('stg_web_events') }}
),

start_mobile_events_cleaned as (

    select * from {{ ref('stg_mobile_events') }}
)

combined_events as (
    
SELECT
  w.event_id,
  w.event_type AS web_event_type,
  w.event_timestamp AS web_event_timestamp,
  w.user_id AS web_user_id,
  w.page_url,
  w.browser,
  w.device_type AS web_device_type,
  w.country AS web_country,
  w.duration_seconds AS web_duration_seconds,
  w.conversion_status AS web_conversion_status,
  m.event_type AS mobile_event_type,
  m.event_timestamp AS mobile_event_timestamp,
  m.user_id AS mobile_user_id,
  m.app_name,
  m.operating_system,
  m.country AS mobile_country,
  m.duration_seconds AS mobile_duration_seconds,
  m.conversion_status AS mobile_conversion_status
FROM start_web_events_cleaned w
JOIN start_mobile_events_cleaned m ON w.event_id = m.event_id;

),

web_event_counts as (
    SELECT
  web_event_type,
  COUNT(*) AS event_count
FROM combined_events
GROUP BY web_event_type;
)

select * from web_event_counts