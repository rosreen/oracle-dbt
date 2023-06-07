--Get the top 3 countries with the highest number of events in both web_events and mobile_events tables:

SELECT country, SUM(event_count) AS total_events
FROM (
    SELECT country, COUNT(*) AS event_count
    FROM web_events
    GROUP BY country
    UNION ALL
    SELECT country, COUNT(*) AS event_count
    FROM mobile_events
    GROUP BY country
)
GROUP BY country
ORDER BY total_events DESC
FETCH FIRST 3 ROWS ONLY;
