
  
  create or replace view FAWDBTCORE.mobile_events_null_vals as
    with start_mobile_events_cleaned as (

    select * from FAWDBTCORE.stg_mobile_events
),

mobile_events_null_vals as (
    
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN EVENT_ID IS NULL THEN 1 ELSE 0 END) AS event_id_null_count,
    (SUM(CASE WHEN EVENT_ID IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS event_id_null_percentage,
    SUM(CASE WHEN EVENT_TYPE IS NULL THEN 1 ELSE 0 END) AS event_type_null_count,
    (SUM(CASE WHEN EVENT_TYPE IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS event_type_null_percentage,
    SUM(CASE WHEN EVENT_TIMESTAMP IS NULL THEN 1 ELSE 0 END) AS event_timestamp_null_count,
    (SUM(CASE WHEN EVENT_TIMESTAMP IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS event_timestamp_null_percentage,
    SUM(CASE WHEN USER_ID IS NULL THEN 1 ELSE 0 END) AS user_id_null_count,
    (SUM(CASE WHEN USER_ID IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS user_id_null_percentage,
    SUM(CASE WHEN APP_NAME IS NULL THEN 1 ELSE 0 END) AS app_name_null_count,
    (SUM(CASE WHEN APP_NAME IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS app_name_null_percentage,
    SUM(CASE WHEN OPERATING_SYSTEM IS NULL THEN 1 ELSE 0 END) AS operating_system_null_count,
    (SUM(CASE WHEN OPERATING_SYSTEM IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS operating_system_null_percentage,
    SUM(CASE WHEN COUNTRY IS NULL THEN 1 ELSE 0 END) AS country_null_count,
    (SUM(CASE WHEN COUNTRY IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS country_null_percentage,
    SUM(CASE WHEN DURATION_SECONDS IS NULL THEN 1 ELSE 0 END) AS duration_seconds_null_count,
    (SUM(CASE WHEN DURATION_SECONDS IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS duration_seconds_null_percentage,
    SUM(CASE WHEN CONVERSION_STATUS IS NULL THEN 1 ELSE 0 END) AS conversion_status_null_count,
    (SUM(CASE WHEN CONVERSION_STATUS IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS conversion_status_null_percentage,
    SUM(CASE WHEN CREATED_AT IS NULL THEN 1 ELSE 0 END) AS created_at_null_count,
    (SUM(CASE WHEN CREATED_AT IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS created_at_null_percentage
    -- SUM(CASE WHEN SESSION_ID IS NULL THEN 1 ELSE 0 END) AS session_id_null_count,
    -- (SUM(CASE WHEN SESSION_ID IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS session_id_null_percentage,
    -- SUM(CASE WHEN SCREEN_RESOLUTION IS NULL THEN 1 ELSE 0 END) AS screen_resolution_null_count,
    -- (SUM(CASE WHEN SCREEN_RESOLUTION IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS screen_resolution_null_percentage
FROM start_mobile_events_cleaned

)

select * from mobile_events_null_vals

