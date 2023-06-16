
  
  create or replace view FAWDBTCORE.ranked_web_events as
    with start_ranked_web_events as (

    select * from FAWDBTCORE.stg_web_events

),

ranked_web_events as (

SELECT

  duration_seconds,
  
  SUM(duration_seconds) OVER (ORDER BY event_timestamp) AS running_total
FROM start_ranked_web_events

)

select * from ranked_web_events

