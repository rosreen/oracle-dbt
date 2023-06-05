SELECT event_id, event_type,
       CASE WHEN duration_seconds > 60 THEN 'Long' ELSE 'Short' END AS duration_category
FROM web_events;
