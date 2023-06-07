-- Extracting relevant columns from web_events table
CREATE TABLE web_events_extracted AS
SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  page_url,
  browser,
  device_type,
  country,
  duration_seconds,
  conversion_status
FROM web_events;

-- Extracting relevant columns from mobile_events table
CREATE TABLE mobile_events_extracted AS
SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  app_name,
  operating_system,
  country,
  duration_seconds,
  conversion_status
FROM mobile_events;


-- Removing duplicate records from web_events_extracted table
CREATE TABLE web_events_cleaned AS
SELECT DISTINCT *
FROM web_events_extracted;

-- Removing duplicate records from mobile_events_extracted table
CREATE TABLE mobile_events_cleaned AS
SELECT DISTINCT *
FROM mobile_events_extracted;


-- Joining web_events_cleaned and mobile_events_cleaned tables
CREATE TABLE combined_events AS
SELECT
  w.event_id,
  w.event_type AS web_event_type,
  w.event_timestamp AS web_event_timestamp,
  w.user_id AS web_user_id,
  w.page_url,
  w.browser,
  w.device_type AS web_device_type,
  w.country AS web_country,
  w.duration_seconds AS web_duration_seconds,
  w.conversion_status AS web_conversion_status,
  m.event_type AS mobile_event_type,
  m.event_timestamp AS mobile_event_timestamp,
  m.user_id AS mobile_user_id,
  m.app_name,
  m.operating_system,
  m.country AS mobile_country,
  m.duration_seconds AS mobile_duration_seconds,
  m.conversion_status AS mobile_conversion_status
FROM web_events_cleaned w
JOIN mobile_events_cleaned m ON w.event_id = m.event_id;


-- Calculate the count of web events by event type
CREATE TABLE web_event_counts AS
SELECT
  web_event_type,
  COUNT(*) AS event_count
FROM combined_events
GROUP BY web_event_type;

-- Calculate the average duration of mobile events by operating system
CREATE TABLE mobile_event_durations AS
SELECT
  operating_system,
  AVG(mobile_duration_seconds) AS avg_duration
FROM combined_events
GROUP BY operating_system;


-- Rank the web events by duration within each device type
CREATE TABLE ranked_web_events AS
SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  page_url,
  browser,
  device_type,
  country,
  duration_seconds,
  conversion_status,
  RANK() OVER (PARTITION BY device_type ORDER BY duration_seconds DESC) AS duration_rank
FROM web_events_cleaned;

-- Categorize web events based on duration
CREATE TABLE categorized_web_events AS
SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  page_url,
  browser,
  device_type,
  country,
  duration_seconds,
  conversion_status,
  CASE
    WHEN duration_seconds < 60 THEN 'Short'
    WHEN duration_seconds < 300 THEN 'Medium'
    ELSE 'Long'
  END AS duration_category
FROM web_events_cleaned;

-- Categorize mobile events based on conversion status
CREATE TABLE categorized_mobile_events AS
SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  app_name,
  operating_system,
  country,
  duration_seconds,
  conversion_status,
  CASE
    WHEN conversion_status = 'Completed' THEN 'Successful'
    ELSE 'Unsuccessful'
  END AS conversion_category
FROM mobile_events_cleaned;


-- Intermediate table: Combined and categorized events
CREATE TABLE combined_categorized_events AS
SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  page_url,
  browser,
  device_type,
  country,
  duration_seconds,
  conversion_status,
  NULL AS app_name,
  
  CASE
    WHEN device_type = 'Desktop' THEN 'Web'
    ELSE 'Mobile'
  END AS platform,
  CASE
    WHEN device_type = 'Desktop' THEN duration_seconds
    ELSE NULL
  END AS web_duration_seconds,
  CASE
    WHEN device_type = 'Mobile' THEN duration_seconds
    ELSE NULL
  END AS mobile_duration_seconds
FROM categorized_web_events
UNION ALL
SELECT
  event_id,
  event_type,
  event_timestamp,
  user_id,
  NULL AS page_url,
  NULL AS browser,
  NULL AS device_type,
  country,
  duration_seconds,
  conversion_status,
  app_name,
  
  'Mobile' AS platform,
  NULL AS web_duration_seconds,
  duration_seconds AS mobile_duration_seconds
FROM categorized_mobile_events;

-- Ending table: Overall event counts by platform
CREATE TABLE event_counts_by_platform AS
SELECT
  platform,

  COUNT(*) AS event_count
FROM combined_categorized_events
GROUP BY platform;

-- Ending table: Average duration by platform and country
CREATE TABLE average_duration_by_platform_country AS
SELECT
  platform,
  country,
  AVG(CASE WHEN platform = 'Web' THEN web_duration_seconds ELSE mobile_duration_seconds END) AS avg_duration
FROM combined_categorized_events
GROUP BY platform, country;

