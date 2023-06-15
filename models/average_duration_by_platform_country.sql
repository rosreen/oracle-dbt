
{{
    config(
        materialized='incremental'  
              )
}}

with start_web_events_cleaned as (

    select * from {{ ref('stg_web_events') }}
),

start_mobile_events_cleaned as (

    select * from {{ ref('stg_mobile_events') }}
), 

categorized_web_events as (
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
  CASE
    WHEN duration_seconds < 60 THEN 'Short'
    WHEN duration_seconds < 300 THEN 'Medium'
    ELSE 'Long'
  END AS duration_category
FROM start_web_events_cleaned


),

 categorized_mobile_events as (
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
  CASE
    WHEN conversion_status = 'Completed' THEN 'Successful'
    ELSE 'Unsuccessful'
  END AS conversion_category
FROM start_mobile_events_cleaned
),


combined_categorized_events as (
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
  NULL AS app_name,
  
  CASE
    WHEN device_type = 'Desktop' THEN 'Web'
    ELSE 'Mobile'
  END AS platform,
  CASE
    WHEN device_type = 'Desktop' THEN duration_seconds
    ELSE NULL
  END AS web_duration_seconds,
  CASE
    WHEN device_type = 'Mobile' THEN duration_seconds
    ELSE NULL
  END AS mobile_duration_seconds
FROM categorized_web_events
UNION ALL
SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  NULL AS page_url,
  NULL AS browser,
  NULL AS device_type,
  country,
  duration_seconds,
  conversion_status,
  app_name,
  
  'Mobile' AS platform,
  NULL AS web_duration_seconds,
  duration_seconds AS mobile_duration_seconds
FROM categorized_mobile_events
),

average_duration_by_platform_country as (

SELECT
  platform,
  country,
  event_timestamp,
  event_id,
  AVG(CASE WHEN platform = 'Web' THEN web_duration_seconds ELSE mobile_duration_seconds END) AS avg_duration
FROM combined_categorized_events
GROUP BY platform, country, event_timestamp, event_id
)

select * from average_duration_by_platform_country

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
where event_timestamp >= (select max(event_timestamp) from {{ this }})

{% endif %}