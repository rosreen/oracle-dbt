

with events as (

    select * from {{ ref('combined_categorized_events') }}
),


event_counts_by_platform as (

    SELECT
  platform,
  COUNT(*) AS event_count
FROM events
GROUP BY platform
)

select * from event_counts_by_platform

