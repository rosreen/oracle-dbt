/*
Retrieve the total count of web events and mobile events for each country, along with the overall percentage of events:
*/

SELECT 
    country,
    SUM(web_event_count) AS total_web_events,
    SUM(mobile_event_count) AS total_mobile_events,
    SUM(web_event_count + mobile_event_count) AS total_events,
    ROUND((SUM(web_event_count + mobile_event_count) * 100.0) / 
          (SUM(SUM(web_event_count + mobile_event_count)) OVER()), 2) AS event_percentage
FROM (
    SELECT country, COUNT(*) AS web_event_count, 0 AS mobile_event_count
    FROM web_events
    GROUP BY country
    UNION ALL
    SELECT country, 0 AS web_event_count, COUNT(*) AS mobile_event_count
    FROM mobile_events
    GROUP BY country
)
GROUP BY country;
