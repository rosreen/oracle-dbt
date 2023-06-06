SELECT event_id, event_type, JSON_VALUE(user_properties, '$.country') AS country
FROM web_events;
