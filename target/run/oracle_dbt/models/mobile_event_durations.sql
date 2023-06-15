
      insert  into  FAWDBTCORE.mobile_event_durations (OPERATING_SYSTEM, WEB_EVENT_TIMESTAMP, AVG_DURATION)
    (
       select OPERATING_SYSTEM, WEB_EVENT_TIMESTAMP, AVG_DURATION
       from o$pt_mobile_event_durations123821285678
    )
  