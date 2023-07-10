with events as (

    select * from FAWDBTCORE.combined_categorized_events
),


event_type_counts as (
SELECT EVENT_TYPE, 
       COUNT(CASE WHEN DEVICE_TYPE = 'Mobile' THEN 1 END) AS Mobile_Count,
       COUNT(CASE WHEN DEVICE_TYPE = 'Desktop' THEN 1 END) AS Desktop_Count
FROM combined_categorized_events
GROUP BY EVENT_TYPE
)

select * from event_type_counts