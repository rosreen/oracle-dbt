
with start_web_events_cleaned as (

    select * from {{ ref('stg_web_events') }}
),

web_events_null_vals as (
    
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN event_id IS NULL THEN 1 ELSE 0 END) AS event_id_null_count,
    (SUM(CASE WHEN event_id IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS event_id_null_percentage,
    SUM(CASE WHEN event_type IS NULL THEN 1 ELSE 0 END) AS event_type_null_count,
    (SUM(CASE WHEN event_type IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS event_type_null_percentage,
    SUM(CASE WHEN event_timestamp IS NULL THEN 1 ELSE 0 END) AS event_timestamp_null_count,
    (SUM(CASE WHEN event_timestamp IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS event_timestamp_null_percentage,
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS user_id_null_count,
    (SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS user_id_null_percentage,
    SUM(CASE WHEN page_url IS NULL THEN 1 ELSE 0 END) AS page_url_null_count,
    (SUM(CASE WHEN page_url IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS page_url_null_percentage,
    SUM(CASE WHEN browser IS NULL THEN 1 ELSE 0 END) AS browser_null_count,
    (SUM(CASE WHEN browser IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS browser_null_percentage,
    SUM(CASE WHEN device_type IS NULL THEN 1 ELSE 0 END) AS device_type_null_count,
    (SUM(CASE WHEN device_type IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS device_type_null_percentage,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_null_count,
    (SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS country_null_percentage,
    SUM(CASE WHEN duration_seconds IS NULL THEN 1 ELSE 0 END) AS duration_seconds_null_count,
    (SUM(CASE WHEN duration_seconds IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS duration_seconds_null_percentage,
    SUM(CASE WHEN conversion_status IS NULL THEN 1 ELSE 0 END) AS conversion_status_null_count,
    (SUM(CASE WHEN conversion_status IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS conversion_status_null_percentage,
    SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS created_at_null_count,
    (SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS created_at_null_percentage
FROM start_web_events_cleaned

)

select * from web_events_null_vals 

