{% macro custom_transformation() %}
  SELECT event_id, event_type, event_timestamp
  FROM web_events
  WHERE event_type = 'click'
  ORDER BY event_timestamp DESC
  LIMIT 100;
{% endmacro %}
