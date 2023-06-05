
SELECT country, COUNT(*) AS event_count
FROM web_events
GROUP BY country;
