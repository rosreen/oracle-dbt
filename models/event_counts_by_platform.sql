with start_web_events_cleaned as (

    select * from {{ ref('stg_web_events') }}
),

start_mobile_events_cleaned as (

    select * from {{ ref('stg_mobile_events') }}
), 