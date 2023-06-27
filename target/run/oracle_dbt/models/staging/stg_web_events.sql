
      merge  into FAWDBTCORE.stg_web_events DBT_INTERNAL_DEST
          using o$pt_stg_web_events155506604692 DBT_INTERNAL_SOURCE
          on (
            DBT_INTERNAL_SOURCE.EVENT_ID = DBT_INTERNAL_DEST.EVENT_ID
        )
        when matched then
          update set
          DBT_INTERNAL_DEST.EVENT_TYPE = DBT_INTERNAL_SOURCE.EVENT_TYPE, 
          DBT_INTERNAL_DEST.EVENT_TIMESTAMP = DBT_INTERNAL_SOURCE.EVENT_TIMESTAMP, 
          DBT_INTERNAL_DEST.USER_ID = DBT_INTERNAL_SOURCE.USER_ID, 
          DBT_INTERNAL_DEST.PAGE_URL = DBT_INTERNAL_SOURCE.PAGE_URL, 
          DBT_INTERNAL_DEST.BROWSER = DBT_INTERNAL_SOURCE.BROWSER, 
          DBT_INTERNAL_DEST.DEVICE_TYPE = DBT_INTERNAL_SOURCE.DEVICE_TYPE, 
          DBT_INTERNAL_DEST.COUNTRY = DBT_INTERNAL_SOURCE.COUNTRY, 
          DBT_INTERNAL_DEST.DURATION_SECONDS = DBT_INTERNAL_SOURCE.DURATION_SECONDS, 
          DBT_INTERNAL_DEST.CONVERSION_STATUS = DBT_INTERNAL_SOURCE.CONVERSION_STATUS, 
          DBT_INTERNAL_DEST.CREATED_AT = DBT_INTERNAL_SOURCE.CREATED_AT
          when not matched then
          insert(EVENT_ID, EVENT_TYPE, EVENT_TIMESTAMP, USER_ID, PAGE_URL, BROWSER, DEVICE_TYPE, COUNTRY, DURATION_SECONDS, CONVERSION_STATUS, CREATED_AT)
          values(
            DBT_INTERNAL_SOURCE.EVENT_ID, 
            DBT_INTERNAL_SOURCE.EVENT_TYPE, 
            DBT_INTERNAL_SOURCE.EVENT_TIMESTAMP, 
            DBT_INTERNAL_SOURCE.USER_ID, 
            DBT_INTERNAL_SOURCE.PAGE_URL, 
            DBT_INTERNAL_SOURCE.BROWSER, 
            DBT_INTERNAL_SOURCE.DEVICE_TYPE, 
            DBT_INTERNAL_SOURCE.COUNTRY, 
            DBT_INTERNAL_SOURCE.DURATION_SECONDS, 
            DBT_INTERNAL_SOURCE.CONVERSION_STATUS, 
            DBT_INTERNAL_SOURCE.CREATED_AT
            )
  