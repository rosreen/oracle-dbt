DELETE FROM web_events
WHERE ROWID NOT IN
(
  SELECT MIN(ROWID)
  FROM web_events
  GROUP BY event_id, event_type, event_timestamp, user_id
);

