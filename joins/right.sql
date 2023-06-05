SELECT
  me.user_id,
  COUNT(we.event_id) AS web_event_count,
  MAX(we.event_timestamp) AS max_web_event_timestamp
FROM
  web_events we
RIGHT JOIN
  mobile_events me ON we.user_id = me.user_id
GROUP BY
  me.user_id;
