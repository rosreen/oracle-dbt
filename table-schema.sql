CREATE TABLE web_events(
  event_id NUMBER primary key,
  event_type VARCHAR2(50),
  event_timestamp TIMESTAMP,
  user_id NUMBER,
  page_url VARCHAR2(100),
  browser VARCHAR2(50),
  device_type VARCHAR2(50),
  country VARCHAR2(50),
  duration_seconds NUMBER,
  conversion_status VARCHAR2(20),
  created_at TIMESTAMP,
  session_id NUMBER,
  page_title VARCHAR2(100)
);


INSERT INTO web_events (event_id, event_type, event_timestamp, user_id, page_url, browser, device_type, country, duration_seconds, conversion_status, created_at, session_id, page_title)
SELECT
  level AS event_id,
  CASE
    WHEN MOD(level, 5) = 0 THEN 'Page View'
    WHEN MOD(level, 5) = 1 THEN 'Click'
    WHEN MOD(level, 5) = 2 THEN 'Scroll'
    WHEN MOD(level, 5) = 3 THEN 'Page Forward'
    ELSE 'Page Backward'
  END AS event_type,
  TIMESTAMP '2023-06-01 00:00:00' + NUMTODSINTERVAL(level * 5, 'MINUTE') AS event_timestamp,
  ROUND(DBMS_RANDOM.VALUE(1, 1000)) AS user_id,
  'http://webapp.com/profile' || level AS page_url,
  CASE
    WHEN MOD(level, 4) = 0 THEN 'Chrome'
    WHEN MOD(level, 4) = 1 THEN 'Firefox'
    WHEN MOD(level, 4) = 2 THEN 'Edge'
    ELSE 'Safari'
  END AS browser,
  CASE
    WHEN MOD(level, 2) = 0 THEN 'Desktop'
    ELSE 'Mobile'
  END AS device_type,
  CASE
    WHEN MOD(level, 6) = 0 THEN 'USA'
    WHEN MOD(level, 6) = 1 THEN 'UK'
    WHEN MOD(level, 6) = 2 THEN 'Canada'
    WHEN MOD(level, 6) = 3 THEN 'Mexico'
    WHEN MOD(level, 6) = 4 THEN 'China'
    ELSE 'Germany'
  END AS country,
  ROUND(DBMS_RANDOM.VALUE(1, 600)) AS duration_seconds,
  CASE
    WHEN MOD(level, 5) = 0 THEN 'Completed'
    WHEN MOD(level, 5) = 1 THEN 'Pending'
    WHEN MOD(level, 5) = 2 THEN 'Failed'
    WHEN MOD(level, 5) = 3 THEN 'Abandoned'
    ELSE 'In Progress'
  END AS conversion_status,
CURRENT_TIMESTAMP AS created_at,
ROUND(DBMS_RANDOM.VALUE(1, 1000000)) AS session_id,
'Page Title ' || level AS page_title
FROM dual
CONNECT BY level <= 10000000;



CREATE TABLE mobile_events (
  event_id NUMBER primary key,
  event_type VARCHAR2(50),
  event_timestamp TIMESTAMP,
  user_id NUMBER,
  app_name VARCHAR2(50),
  operating_system VARCHAR2(50),
  country VARCHAR2(50),
  duration_seconds NUMBER,
  conversion_status VARCHAR2(20),
  created_at TIMESTAMP,
  session_id NUMBER,
  screen_resolution VARCHAR2(20)
);

INSERT INTO mobile_events (event_id, event_type, event_timestamp, user_id, app_name, operating_system, country, duration_seconds, conversion_status, created_at, session_id, screen_resolution)
SELECT
 level AS event_id,
 CASE
  WHEN MOD(level, 3) = 0 THEN 'App Launch'
  WHEN MOD(level, 3) = 1 THEN 'Push Notification'
  ELSE 'In-App Purchase'
 END AS event_type,
 TIMESTAMP '2023-06-01 00:00:00' + NUMTODSINTERVAL(level * 5, 'MINUTE') AS event_timestamp,
 ROUND(DBMS_RANDOM.VALUE(1, 1000)) AS user_id,
 'App' || level AS app_name,
 CASE
  WHEN MOD(level, 4) = 0 THEN 'Android'
  WHEN MOD(level, 4) = 1 THEN 'iOS'
  WHEN MOD(level, 4) = 2 THEN 'Linux'
  ELSE 'Windows'
 END AS operating_system,
 CASE
    WHEN MOD(level, 6) = 0 THEN 'USA'
    WHEN MOD(level, 6) = 1 THEN 'UK'
    WHEN MOD(level, 6) = 2 THEN 'Canada'
    WHEN MOD(level, 6) = 3 THEN 'Mexico'
    WHEN MOD(level, 6) = 4 THEN 'China'
    ELSE 'Germany'
 END AS country,
 ROUND(DBMS_RANDOM.VALUE(1, 600)) AS duration_seconds,
 CASE
  WHEN MOD(level, 5) = 0 THEN 'Completed'
  WHEN MOD(level, 5) = 1 THEN 'Pending'
  WHEN MOD(level, 5) = 2 THEN 'Failed'
  WHEN MOD(level, 5) = 3 THEN 'Abandoned'
  ELSE 'In Progress'
 END AS conversion_status,
 CURRENT_TIMESTAMP AS created_at,
 ROUND(DBMS_RANDOM.VALUE(1, 1000000)) AS session_id,
 'Resolution ' || level AS screen_resolution
FROM dual
CONNECT BY level <= 10000000;
