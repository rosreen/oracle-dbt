/* creating a table (web_events) that measures relevant web_event metrics such as event id, event type, timestamps, device types, etc. */

CREATE TABLE web_events (
  event_id NUMBER,
  event_type VARCHAR2(50),
  event_timestamp TIMESTAMP,
  user_id NUMBER,
  page_url VARCHAR2(100),
  browser VARCHAR2(50),
  device_type VARCHAR2(50),
  country VARCHAR2(50),
  duration_seconds NUMBER,
  conversion_status VARCHAR2(20)
);

/* inserting 10,000,000 randomly generated rows into the web_events table */

INSERT INTO web_events (event_id, event_type, event_timestamp, user_id, page_url, browser, device_type, country, duration_seconds, conversion_status)
SELECT
  level AS event_id,
  CASE
    WHEN MOD(level, 2) = 0 THEN 'Page View'
    ELSE 'Click'
  END AS event_type,
  TIMESTAMP '2023-06-01 00:00:00' + NUMTODSINTERVAL(level * 5, 'MINUTE') AS event_timestamp,
  ROUND(DBMS_RANDOM.VALUE(1, 1000)) AS user_id,
  'http://example.com/page' || level AS page_url,
  CASE
    WHEN MOD(level, 3) = 0 THEN 'Chrome'
    WHEN MOD(level, 3) = 1 THEN 'Firefox'
    ELSE 'Safari'
  END AS browser,
  CASE
    WHEN MOD(level, 2) = 0 THEN 'Desktop'
    ELSE 'Mobile'
  END AS device_type,
  CASE
    WHEN MOD(level, 4) = 0 THEN 'USA'
    WHEN MOD(level, 4) = 1 THEN 'UK'
    WHEN MOD(level, 4) = 2 THEN 'Canada'
    ELSE 'Germany'
  END AS country,
  ROUND(DBMS_RANDOM.VALUE(1, 600)) AS duration_seconds,
  CASE
    WHEN MOD(level, 5) = 0 THEN 'Completed'
    WHEN MOD(level, 5) = 1 THEN 'Pending'
    WHEN MOD(level, 5) = 2 THEN 'Failed'
    WHEN MOD(level, 5) = 3 THEN 'Abandoned'
    ELSE 'In Progress'
  END AS conversion_status
FROM dual
CONNECT BY level <= 10000000;

/* creating a table (mobile_events) that measures relevant mobile_event metrics such as event id, event type, timestamps, operating systems, etc. */

CREATE TABLE mobile_events (
  event_id NUMBER,
  event_type VARCHAR2(50),
  event_timestamp TIMESTAMP,
  user_id NUMBER,
  app_name VARCHAR2(50),
  operating_system VARCHAR2(50),
  country VARCHAR2(50),
  duration_seconds NUMBER,
  conversion_status VARCHAR2(20)
);


/* inserting 10,000,000 randomly generated rows into the mobile_events table */

INSERT INTO mobile_events (event_id, event_type, event_timestamp, user_id, app_name, operating_system, country, duration_seconds, conversion_status)
SELECT
 level AS event_id,
 CASE
  WHEN MOD(level, 2) = 0 THEN 'App Launch'
  ELSE 'In-App Purchase'
 END AS event_type,
 TIMESTAMP '2023-06-01 00:00:00' + NUMTODSINTERVAL(level * 5, 'MINUTE') AS event_timestamp,
 ROUND(DBMS_RANDOM.VALUE(1, 1000)) AS user_id,
 'App' || level AS app_name,
 CASE
  WHEN MOD(level, 3) = 0 THEN 'Android'
  WHEN MOD(level, 3) = 1 THEN 'iOS'
  ELSE 'Windows'
 END AS operating_system,
 CASE
  WHEN MOD(level, 4) = 0 THEN 'USA'
  WHEN MOD(level, 4) = 1 THEN 'UK'
  WHEN MOD(level, 4) = 2 THEN 'Canada'
  ELSE 'Germany'
 END AS country,
 ROUND(DBMS_RANDOM.VALUE(1, 600)) AS duration_seconds,
 CASE
  WHEN MOD(level, 5) = 0 THEN 'Completed'
  WHEN MOD(level, 5) = 1 THEN 'Pending'
  WHEN MOD(level, 5) = 2 THEN 'Failed'
  WHEN MOD(level, 5) = 3 THEN 'Abandoned'
  ELSE 'In Progress'
 END AS conversion_status
FROM dual
CONNECT BY level <= 10000000;
