
      insert  into  FAWDBTCORE.average_duration_by_platform_country (PLATFORM, COUNTRY, EVENT_TIMESTAMP, EVENT_ID, AVG_DURATION)
    (
       select PLATFORM, COUNTRY, EVENT_TIMESTAMP, EVENT_ID, AVG_DURATION
       from o$pt_average_duration_by_platform_country123821281173
    )
  