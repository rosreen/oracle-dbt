SELECT event_timestamp, event_type, user_id, 
       SUM(duration_seconds) OVER (PARTITION BY user_id ORDER BY event_timestamp) AS running_total
FROM web_events;
