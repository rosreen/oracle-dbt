
  
  create or replace view FAWDBTCORE.mobile_events_max_min_vals as
    with start_mobile_events_cleaned as (

    select * from FAWDBTCORE.stg_mobile_events
),

mobile_events_max_min_vals as (
SELECT
    MIN(EVENT_ID) AS event_id_min,
    MAX(EVENT_ID) AS event_id_max,
    MIN(EVENT_TYPE) AS event_type_min,
    MAX(EVENT_TYPE) AS event_type_max,
    MIN(EVENT_TIMESTAMP) AS event_timestamp_min,
    MAX(EVENT_TIMESTAMP) AS event_timestamp_max,
    MIN(USER_ID) AS user_id_min,
    MAX(USER_ID) AS user_id_max,
    MIN(APP_NAME) AS app_name_min,
    MAX(APP_NAME) AS app_name_max,
    MIN(OPERATING_SYSTEM) AS operating_system_min,
    MAX(OPERATING_SYSTEM) AS operating_system_max,
    MIN(COUNTRY) AS country_min,
    MAX(COUNTRY) AS country_max,
    MIN(DURATION_SECONDS) AS duration_seconds_min,
    MAX(DURATION_SECONDS) AS duration_seconds_max,
    MIN(CONVERSION_STATUS) AS conversion_status_min,
    MAX(CONVERSION_STATUS) AS conversion_status_max,
    MIN(CREATED_AT) AS created_at_min,
    MAX(CREATED_AT) AS created_at_max
    -- MIN(SESSION_ID) AS session_id_min,
    -- MAX(SESSION_ID) AS session_id_max
    -- MIN(SCREEN_RESOLUTION) AS screen_resolution_min,
    -- MAX(SCREEN_RESOLUTION) AS screen_resolution_max
FROM
    start_mobile_events_cleaned
)

select * from mobile_events_max_min_vals

