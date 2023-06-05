SELECT *
FROM
(
  SELECT user_id, attribute, value
  FROM web_events
  UNPIVOT (value FOR attribute IN (page_url, browser))
)
PIVOT
(
  MAX(value)
  FOR attribute IN ('page_url', 'browser')
);
