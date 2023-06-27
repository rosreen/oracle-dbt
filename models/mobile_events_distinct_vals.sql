
with start_mobile_events_cleaned as (

    select * from {{ ref('stg_mobile_events') }}
),

mobile_events_distinct_vals as (
SELECT
    'EVENT_ID' AS COLUMN_NAME,
    COUNT(DISTINCT EVENT_ID) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

UNION ALL

SELECT
    'EVENT_TYPE' AS COLUMN_NAME,
    COUNT(DISTINCT EVENT_TYPE) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

UNION ALL

SELECT
    'EVENT_TIMESTAMP' AS COLUMN_NAME,
    COUNT(DISTINCT EVENT_TIMESTAMP) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

UNION ALL

SELECT
    'USER_ID' AS COLUMN_NAME,
    COUNT(DISTINCT USER_ID) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

UNION ALL

SELECT
    'APP_NAME' AS COLUMN_NAME,
    COUNT(DISTINCT APP_NAME) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

UNION ALL

SELECT
    'OPERATING_SYSTEM' AS COLUMN_NAME,
    COUNT(DISTINCT OPERATING_SYSTEM) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

UNION ALL

SELECT
    'COUNTRY' AS COLUMN_NAME,
    COUNT(DISTINCT COUNTRY) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

UNION ALL

SELECT
    'DURATION_SECONDS' AS COLUMN_NAME,
    COUNT(DISTINCT DURATION_SECONDS) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

UNION ALL

SELECT
    'CONVERSION_STATUS' AS COLUMN_NAME,
    COUNT(DISTINCT CONVERSION_STATUS) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

UNION ALL

SELECT
    'CREATED_AT' AS COLUMN_NAME,
    COUNT(DISTINCT CREATED_AT) AS DISTINCT_COUNT
FROM
    start_mobile_events_cleaned

-- UNION ALL

-- SELECT
--     'SESSION_ID' AS COLUMN_NAME,
--     COUNT(DISTINCT SESSION_ID) AS DISTINCT_COUNT
-- FROM
--     start_mobile_events_cleaned

-- UNION ALL

-- SELECT
--     'SCREEN_RESOLUTION' AS COLUMN_NAME,
--     COUNT(DISTINCT SCREEN_RESOLUTION) AS DISTINCT_COUNT
-- FROM
--     start_mobile_events_cleaned

)

select * from mobile_events_distinct_vals 

