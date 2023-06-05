SELECT user_id, COUNT(user_id) as num_user_id, sum(duration_seconds), max(duration_seconds), min(duration_seconds), avg(duration_seconds)
FROM web_events
GROUP BY user_id;