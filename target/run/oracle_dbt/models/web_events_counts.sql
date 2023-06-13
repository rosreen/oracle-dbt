
      merge  into FAWDBTCORE.web_events_counts DBT_INTERNAL_DEST
          using o$pt_web_events_counts165353063303 DBT_INTERNAL_SOURCE
          on (
            DBT_INTERNAL_SOURCE.EVENT_ID = DBT_INTERNAL_DEST.EVENT_ID
        )
        when matched then
          update set
          DBT_INTERNAL_DEST.WEB_EVENT_TYPE = DBT_INTERNAL_SOURCE.WEB_EVENT_TYPE, 
          DBT_INTERNAL_DEST.WEB_EVENT_TIMESTAMP = DBT_INTERNAL_SOURCE.WEB_EVENT_TIMESTAMP, 
          DBT_INTERNAL_DEST.EVENT_COUNT = DBT_INTERNAL_SOURCE.EVENT_COUNT
          when not matched then
          insert(WEB_EVENT_TYPE, WEB_EVENT_TIMESTAMP, EVENT_COUNT)
          values(
            DBT_INTERNAL_SOURCE.WEB_EVENT_TYPE, 
            DBT_INTERNAL_SOURCE.WEB_EVENT_TIMESTAMP, 
            DBT_INTERNAL_SOURCE.EVENT_COUNT
            )
  