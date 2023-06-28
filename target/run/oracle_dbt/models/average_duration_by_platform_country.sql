
  
  create or replace view FAWDBTCORE.average_duration_by_platform_country as
    with start_web_events_cleaned as (

    select * from FAWDBTCORE.combined_categorized_events
), 

average_duration_by_platform_country as (

SELECT
  platform,
  country,
  ROUND(AVG(CASE WHEN platform = 'Web' THEN web_duration_seconds ELSE mobile_duration_seconds END), 2) AS avg_duration
FROM combined_categorized_events
GROUP BY platform, country
ORDER BY platform
)

select * from average_duration_by_platform_country

