{{
    config(
        materialized='incremental'
        
        )
}}


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
  conversion_status
    FROM {{ source('FAWDBTCORE', 'web_events') }}
),

web_events_cleaned as (
    SELECT DISTINCT *
    FROM web_events_extracted
)

select * from web_events_cleaned

{% if is_incremental() %}
{{ log("This is an incremental run", info=True) }}

  -- this filter will only be applied on an incremental run
where event_timestamp >= (select max(event_timestamp) from {{ this }})

{% endif %}