with start_web_events_cleaned as (

    select * from FAWDBTCORE.stg_web_events
),

web_events_max_min_vals as (
SELECT
    MIN(EVENT_ID) AS event_id_min,
    MAX(EVENT_ID) AS event_id_max,
    MIN(EVENT_TYPE) AS event_type_min,
    MAX(EVENT_TYPE) AS event_type_max,
    MIN(EVENT_TIMESTAMP) AS event_timestamp_min,
    MAX(EVENT_TIMESTAMP) AS event_timestamp_max,
    MIN(USER_ID) AS user_id_min,
    MAX(USER_ID) AS user_id_max,
    MIN(PAGE_URL) AS page_url_min,
    MAX(PAGE_URL) AS page_url_max,
    MIN(BROWSER) AS browser_min,
    MAX(BROWSER) AS browser_max,
    MIN(DEVICE_TYPE) AS device_type_min,
    MAX(DEVICE_TYPE) AS device_type_max,
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
    -- MIN(PAGE_TITLE) AS page_title_min,
    -- MAX(PAGE_TITLE) AS page_title_max
FROM
    start_web_events_cleaned
)

select * from web_events_max_min_vals