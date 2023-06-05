SELECT event_id, event_type, 'page_url' AS attribute, page_url AS value
FROM web_events
UNION ALL
SELECT event_id, event_type, 'browser' AS attribute, browser AS value
FROM web_events;
