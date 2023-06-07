SELECT
  we.user_id,
  COUNT(DISTINCT we.event_id) AS web_event_count,
   AVG(we.duration_seconds) AS avg_web_duration
FROM
  web_events we
LEFT JOIN
  mobile_events me ON we.user_id = me.user_id
WHERE
  we.country = 'USA'
  AND me.country = 'USA'
  AND we.event_type = 'Page View'
  AND me.operating_system = 'Android'
GROUP BY
  we.user_id;
