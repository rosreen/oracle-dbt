
SELECT country, COUNT(*) AS event_count
FROM web_events
INNER JOIN mobile_events ON web_events.user_id = mobile_events.user_id;
GROUP BY country;
