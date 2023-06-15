
      insert  into  FAWDBTCORE.web_events_counts (WEB_EVENT_TYPE, WEB_EVENT_TIMESTAMP, EVENT_COUNT)
    (
       select WEB_EVENT_TYPE, WEB_EVENT_TIMESTAMP, EVENT_COUNT
       from o$pt_web_events_counts123843222934
    )
  