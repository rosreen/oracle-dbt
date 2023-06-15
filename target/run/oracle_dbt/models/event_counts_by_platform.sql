
      insert  into  FAWDBTCORE.event_counts_by_platform (PLATFORM, EVENT_TIMESTAMP, EVENT_COUNT)
    (
       select PLATFORM, EVENT_TIMESTAMP, EVENT_COUNT
       from o$pt_event_counts_by_platform123821288305
    )
  